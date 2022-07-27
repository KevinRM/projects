import 'package:auto_size_text/auto_size_text.dart';
import 'package:blokstaking/api/api_communication.dart';
import 'package:blokstaking/api/models/pool.model.dart';
import 'package:blokstaking/api/models/transaction.model.dart';
import 'package:blokstaking/api/request_template.dart';
import 'package:blokstaking/api/response_template.dart';
import 'package:blokstaking/api/routes.dart';
import 'package:blokstaking/constants.dart';
import 'package:blokstaking/shared_components/custom_elevated_button.dart';
import 'package:blokstaking/shared_components/custom_spacer.dart';
import 'package:blokstaking/states/metamask_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletTransactions extends StatefulWidget {
  const WalletTransactions(
      {Key? key, required this.poolModel, required this.callback})
      : super(key: key);

  final PoolModel poolModel;
  final Future<void> Function() callback;

  @override
  State<WalletTransactions> createState() => _WalletTransactionsState();
}

class _WalletTransactionsState extends State<WalletTransactions> {
  var f = NumberFormat('#,###,###,##0.00##');
  List<TransactionModel> transactions = [];
  double _lockedTokens = 0;
  double _estimatedReward = 0;

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 920),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Constants.paletteSelected["shadow"]!.withOpacity(0.55),
                blurRadius: 40)
          ]),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "User Information",
                        style: TextStyle(
                            color: Constants.paletteSelected["light"],
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      const CustomSpacer(verticalSpace: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: AutoSizeText(
                              "- Your Value Locked",
                            ),
                          ),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "\$ ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Constants
                                            .paletteSelected["medium"])),
                                TextSpan(
                                  text: f.format(_lockedTokens *
                                      widget.poolModel.tokenPrice),
                                  style: TextStyle(
                                      color:
                                          Constants.paletteSelected["medium"],
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "RobotoMono"),
                                ),
                              ])),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: AutoSizeText(
                              "- Your Estimated Reward",
                            ),
                          ),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: f.format(_estimatedReward),
                                  style: TextStyle(
                                      color:
                                          Constants.paletteSelected["medium"],
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "RobotoMono"),
                                ),
                                TextSpan(
                                  text: " BLOK",
                                  style: TextStyle(
                                      color: Constants.paletteSelected["light"],
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ])),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Constants.paletteSelected["light"]!))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: AutoSizeText(
                                "Your Locked BLOK Tokens",
                                style: TextStyle(
                                    color: Constants.paletteSelected["light"],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: AutoSizeText(
                                  f.format(_lockedTokens) + " BLOK",
                                  style: TextStyle(
                                      color:
                                          Constants.paletteSelected["medium"],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "RobotoMono"),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: AutoSizeText(
                                "Unlocks on",
                                style: TextStyle(
                                    color: Constants.paletteSelected["light"],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: AutoSizeText(
                                  "Thu Aug 11 2022",
                                  style: TextStyle(
                                      color:
                                          Constants.paletteSelected["medium"],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "RobotoMono"),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const CustomSpacer(verticalSpace: 30),
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 30,
          runSpacing: 10,
          children: [
            CustomElevatedButton(
                text: "Stake BLOK Tokens",
                onPressed: () => context
                    .read<MetaMaskProvider>()
                    .openTransactionDialog(context, loadTransactions)),
            const CustomElevatedButton(text: "Collect")
          ],
        ),
      ],
    );
  }

  Future<void> loadTransactions() async {
    RequestTemplate request = RequestTemplate();
    ResponseTemplate result = await API.post(
        context, APIRoutes.getWalletTransactions, request,
        wallet: context.read<MetaMaskProvider>().currentAddress);

    resetData();

    if (result.correct) {
      for (var value in (result.data['transactions'] as List)) {
        transactions.add(TransactionModel.fromJson(value));
      }
    }

    for (var element in transactions) {
      _lockedTokens += element.amount!;
      var daysStaking = DateTime(2022, 08, 11).difference(element.date!).inDays;
      _estimatedReward +=
          (((element.amount! * widget.poolModel.apy) / 100) / 365) *
              daysStaking;
    }

    setState(() {});
    widget.callback();
  }

  resetData() {
    _lockedTokens = 0;
    _estimatedReward = 0;
    transactions.clear();
  }
}
