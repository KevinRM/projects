import 'dart:async';
import 'package:blokstaking/api/api_communication.dart';
import 'package:blokstaking/api/models/transaction.model.dart';
import 'package:blokstaking/api/request_template.dart';
import 'package:blokstaking/api/response_template.dart';
import 'package:blokstaking/api/routes.dart';
import 'package:blokstaking/constants.dart';
import 'package:blokstaking/shared_components/custom_elevated_button.dart';
import 'package:blokstaking/shared_components/custom_spacer.dart';
import 'package:blokstaking/shared_components/custom_text_form_field.dart';
import 'package:blokstaking/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:flutter_web3/ethers.dart';

class MetaMaskProvider with ChangeNotifier {
  static const operatingChains = [80001]; //[137, 80001];
  ContractERC20? blokToken;
  String currentAddress = "";
  int currentChain = -1;
  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => operatingChains.contains(currentChain);
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;
  Web3Provider? get provider =>
      Ethereum.isSupported ? Web3Provider(Ethereum.provider) : null;

  // Transaction dialog
  final _formKey = GlobalKey<FormState>();
  BigInt userBlokBalance = BigInt.zero;
  double _tokensToTransfer = 0;

  Future<void> connect(BuildContext context) async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        currentAddress = accs.first;
      }
      currentChain = await ethereum!.getChainId();
      Navigator.of(context).pop();
      notifyListeners();
    }
  }

  start() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        reset();
      });
      ethereum!.onChainChanged((chainId) {
        currentChain = chainId;
        notifyListeners();
      });
      ethereum!.onDisconnect((chainId) {
        reset();
      });
    }
  }

  reset() {
    currentAddress = "";
    currentChain = -1;
    notifyListeners();
  }

  isAllCorrect() {
    return isConnected && isInOperatingChain && currentAddress.isNotEmpty;
  }

  getBlokBalance() async {
    // blokToken ??=
    //     ContractERC20(Constants.tokenBlokContract, provider!.getSigner());
    blokToken ??=
        ContractERC20(Constants.tokenMaticContract, provider!.getSigner());
    userBlokBalance = await blokToken!.balanceOf(currentAddress);
  }

  openTransactionDialog(
      BuildContext context, Future<void> Function() callback) {
    showDialog(
        context: context,
        barrierColor: const Color(0xffdcd1e8).withOpacity(0.67),
        builder: (_) => AlertDialog(
              elevation: 0,
              contentPadding: const EdgeInsets.all(0),
              backgroundColor: Constants.paletteSelected["dark"],
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Constants.paletteSelected["light"]!, width: 1.5),
                  borderRadius: BorderRadius.circular(12)),
              content: Form(
                key: _formKey,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 512),
                  width: 512,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomSpacer(verticalSpace: 45),
                      // Title
                      Text(
                        "Stake BLOK",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Constants.paletteSelected["medium"]),
                        textAlign: TextAlign.center,
                      ),
                      // Card
                      const CustomSpacer(verticalSpace: 22),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Constants.paletteSelected["shadow"]!
                                    .withOpacity(0.55),
                                blurRadius: 40)
                          ]),
                          child: Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16.0, 10, 16, 16),
                              child: Column(
                                children: [
                                  Image.asset(
                                    UtilitiesFunctions.parseFilePath(
                                        Constants.metamaskIconPath),
                                    height: 90,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  const CustomSpacer(verticalSpace: 16),
                                  CustomTextFormField(
                                    type: TextInputType.number,
                                    title: "Number tokens",
                                    autofocus: true,
                                    onSaved: (String? value) {
                                      _tokensToTransfer =
                                          double.tryParse(value ?? "0") ?? 0;
                                    },
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "This field is required";
                                      } else if (double.tryParse(value) ==
                                          null) {
                                        return "Invalid number";
                                      } else if (double.tryParse(value)! <
                                          0.01) {
                                        return "The minimum quantity is 0.01";
                                      }
                                      return null;
                                    },
                                  ),
                                  const CustomSpacer(verticalSpace: 26),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomElevatedButton(
                                          text: "Stake tokens",
                                          onPressed: () =>
                                              openMetamaskTransaction(
                                                  context, callback),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Actions
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                text: "Cancel",
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  openMetamaskTransaction(
      BuildContext context, Future<void> Function() callback) async {
    if (_formKey.currentState!.validate()) {
      UtilitiesFunctions.showLoadingIndicatorInDialog(
          context, "Waiting for transaction confirmation");
      _formKey.currentState!.save();
      await getBlokBalance();

      BigInt tokensToTransfer =
          BigInt.from(_tokensToTransfer * 1000000000000000000);

      if (userBlokBalance >= tokensToTransfer) {
        try {
          final tx =
              await blokToken!.transfer(Constants.walletTo, tokensToTransfer);
          await tx.wait();

          TransactionModel trModel = TransactionModel(
              walletAddress: currentAddress,
              transactionHash: tx.hash,
              amount: _tokensToTransfer);

          RequestTemplate request = RequestTemplate(data: trModel.toJson());
          ResponseTemplate result = await API.post(
              context, APIRoutes.saveWalletTransactions, request,
              wallet: currentAddress);

          if (result.correct) {
            callback();
            UtilitiesFunctions.showSnackbar(
                context, "Staking process completed",
                success: true);
          }
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } catch (e) {
          UtilitiesFunctions.showSnackbar(context, "Operation cancelled",
              error: true);
          Navigator.of(context).pop();
        }
      } else {
        Navigator.of(context).pop();
        UtilitiesFunctions.showAlertDialog(
            context, "ERROR", "You don't have enough BLOK in your wallet");
      }
    } else {
      // UtilitiesFunctions.showSnackbar(context, "There are fields with errors");
    }
  }
}
