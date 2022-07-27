import 'package:auto_size_text/auto_size_text.dart';
import 'package:blokstaking/constants.dart';
import 'package:blokstaking/states/metamask_provider.dart';
import 'package:blokstaking/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarComp extends StatefulWidget {
  const AppBarComp({Key? key}) : super(key: key);

  @override
  State<AppBarComp> createState() => _AppBarCompState();
}

class _AppBarCompState extends State<AppBarComp> {
  @override
  Widget build(BuildContext context) {
    MetaMaskProvider metamask = context.watch<MetaMaskProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Image.asset(
              UtilitiesFunctions.parseFilePath(Constants.logoPath),
              height: 64,
              fit: BoxFit.scaleDown),
        ),
        Expanded(child: getWallet(metamask)),
      ],
    );
  }

  Widget getWallet(MetaMaskProvider metamask) {
    String message = "";

    if (metamask.isAllCorrect()) {
      message = "Account: " + metamask.currentAddress;
    } else if (metamask.isConnected && !metamask.isInOperatingChain) {
      message = "Wrong chain. Please connect to Polygon test network";
    } else if (!metamask.isEnabled) {
      message = "Please use a Metamask supported browser";
    }

    Widget widgetsToReturn = const SizedBox();

    if (message.isNotEmpty) {
      widgetsToReturn = FittedBox(
        alignment: Alignment.centerRight,
        fit: BoxFit.scaleDown,
        child: Tooltip(
          message: "Disconnect",
          child: Container(
            constraints: BoxConstraints(
                maxWidth:
                    UtilitiesFunctions.isSmallScreen(context) ? 200 : 720),
            child: TextButton(
                onPressed: () => context.read<MetaMaskProvider>().reset(),
                child: AutoSizeText(
                  message,
                  textAlign: TextAlign.center,
                )),
          ),
        ),
      );
    }

    return widgetsToReturn;
  }

  // List<Widget> getAppBarActions(MetaMaskProvider metamask) {
  //   String message = "";

  //   if (metamask.isAllCorrect()) {
  //     message = "Account: " + metamask.currentAddress;
  //   } else if (metamask.isConnected && !metamask.isInOperatingChain) {
  //     message = "Wrong chain. Please connect to Polygon network";
  //   } else if (!metamask.isEnabled) {
  //     message = "Please use a Metamask supported browser";
  //   }

  //   List<Widget> widgetsToReturn = [];

  //   if (message.isNotEmpty) {
  //     widgetsToReturn.add(Row(
  //       children: [
  //         FittedBox(
  //           fit: BoxFit.scaleDown,
  //           child: Tooltip(
  //             message: "Disconnect",
  //             child: Container(
  //               constraints: BoxConstraints(
  //                   maxWidth:
  //                       UtilitiesFunctions.isSmallScreen(context) ? 200 : 720),
  //               child: TextButton(
  //                   onPressed: () => context.read<MetaMaskProvider>().reset(),
  //                   child: AutoSizeText(
  //                     message,
  //                     textAlign: TextAlign.center,
  //                   )),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ));
  //   }

  //   widgetsToReturn
  //       .add(const CustomSpacer(horizontalSpace: Constants.appDefaultSpacing));

  //   return widgetsToReturn;
  // }
}
