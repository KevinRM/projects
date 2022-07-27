import 'package:auto_size_text/auto_size_text.dart';
import 'package:blokstaking/api/api_communication.dart';
import 'package:blokstaking/api/models/pool.model.dart';
import 'package:blokstaking/api/request_template.dart';
import 'package:blokstaking/api/response_template.dart';
import 'package:blokstaking/api/routes.dart';
import 'package:blokstaking/constants.dart';
import 'package:blokstaking/pages/home/components/wallet_transactions.dart';
import 'package:blokstaking/shared_components/appbar_comp.dart';
import 'package:blokstaking/shared_components/custom_card.dart';
import 'package:blokstaking/shared_components/custom_elevated_button.dart';
import 'package:blokstaking/shared_components/custom_spacer.dart';
import 'package:blokstaking/states/metamask_provider.dart';
import 'package:blokstaking/states/user_state.dart';
import 'package:blokstaking/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var f = NumberFormat('#,###,###,###.##');
  final double maxWidthCard = 452;
  PoolModel _poolModel = PoolModel();

  @override
  void initState() {
    loadPoolInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const PreferredSize(
      //     child: AppBarComp(),
      //     preferredSize: Size.fromHeight(Constants.appToolbarHeight)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    // Appbar
                    buildSection2(
                      Container(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: const AppBarComp()),
                    ),
                    // Text
                    buildSection2(Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          UtilitiesFunctions.parseFilePath(Constants.iconPath),
                          height: 90,
                          fit: BoxFit.scaleDown,
                        ),
                        AutoSizeText(
                          "Bloktopia Staking",
                          style: TextStyle(
                              color: Constants.paletteSelected["light"],
                              fontSize: 45,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        const CustomSpacer(verticalSpace: 8),
                        AutoSizeText(
                          "Stake your BLOK tokens to earn extra BLOK!",
                          style: TextStyle(
                              color: Constants.paletteSelected["medium"],
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                    // Available space
                    buildSection2(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            spacing: 12,
                            children: [
                              Text(f.format(_poolModel.minTokens +
                                      _poolModel.currentTokens) +
                                  " BLOK"),
                              const Text("-"),
                              Text(f.format(_poolModel.maxTokens) + " BLOK")
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            constraints: BoxConstraints(maxWidth: maxWidthCard),
                            child: LinearProgressIndicator(
                              value: calculatePercentage() / 100,
                              minHeight: 10,
                            ),
                          ),
                          Text(calculatePercentage().toStringAsFixed(2) + " %")
                        ],
                      ),
                    ),
                    // Cards
                    buildSection2(
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          CustomCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        "Reward Program",
                                        style: TextStyle(
                                            color: Constants
                                                .paletteSelected["light"],
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const CustomSpacer(verticalSpace: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: AutoSizeText(
                                              "- Max BLOK Reward Value",
                                            ),
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: "\$  ",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Constants
                                                                .paletteSelected[
                                                            "medium"])),
                                                TextSpan(
                                                  text: f.format(_poolModel
                                                      .maxBlokRewardValue),
                                                  style: TextStyle(
                                                      color: Constants
                                                              .paletteSelected[
                                                          "medium"],
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "RobotoMono"),
                                                ),
                                              ])),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: AutoSizeText(
                                              "- APY",
                                            ),
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                  text:
                                                      f.format(_poolModel.apy),
                                                  style: TextStyle(
                                                      color: Constants
                                                              .paletteSelected[
                                                          "medium"],
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "RobotoMono"),
                                                ),
                                                TextSpan(
                                                    text: "  %",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Constants
                                                                .paletteSelected[
                                                            "medium"])),
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
                                              color: Constants
                                                  .paletteSelected["light"]!))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: AutoSizeText(
                                                "Total Locked BLOK Tokens",
                                                style: TextStyle(
                                                    color: Constants
                                                            .paletteSelected[
                                                        "light"],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Flexible(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: AutoSizeText(
                                                  f.format(_poolModel
                                                              .minTokens +
                                                          _poolModel
                                                              .currentTokens) +
                                                      " BLOK",
                                                  style: TextStyle(
                                                      color: Constants
                                                              .paletteSelected[
                                                          "medium"],
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                            constraints: BoxConstraints(maxWidth: maxWidthCard),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidthCard),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Constants.paletteSelected["shadow"]!
                                      .withOpacity(0.55),
                                  blurRadius: 40)
                            ]),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          "Staking Information",
                                          style: TextStyle(
                                              color: Constants
                                                  .paletteSelected["light"],
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const CustomSpacer(verticalSpace: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Flexible(
                                              child: AutoSizeText(
                                                "- Total BLOK Value Locked",
                                              ),
                                            ),
                                            Flexible(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "\$",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Constants
                                                                  .paletteSelected[
                                                              "medium"])),
                                                  TextSpan(
                                                    text: " " +
                                                        f.format((_poolModel
                                                                    .minTokens +
                                                                _poolModel
                                                                    .currentTokens) *
                                                            _poolModel
                                                                .tokenPrice),
                                                    style: TextStyle(
                                                        color: Constants
                                                                .paletteSelected[
                                                            "medium"],
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            "RobotoMono"),
                                                  ),
                                                ])),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Flexible(
                                              child: AutoSizeText(
                                                "- BLOK Token Price",
                                              ),
                                            ),
                                            Flexible(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "\$",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Constants
                                                                  .paletteSelected[
                                                              "medium"])),
                                                  TextSpan(
                                                    text: " " +
                                                        NumberFormat(
                                                                '#,###,###,###.#######')
                                                            .format(_poolModel
                                                                .tokenPrice),
                                                    style: TextStyle(
                                                        color: Constants
                                                                .paletteSelected[
                                                            "medium"],
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            "RobotoMono"),
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
                                                color:
                                                    Constants.paletteSelected[
                                                        "light"]!))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(height: 21)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      constraints: const BoxConstraints(maxWidth: 1200),
                    ),

                    // Button
                    buildUserInfoSection(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserInfoSection(BuildContext context) {
    MetaMaskProvider metamask = context.watch<MetaMaskProvider>();

    if (!metamask.isAllCorrect()) {
      return buildSection2(
        Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomElevatedButton(
                  text: "Connect Wallet",
                  onPressed: () =>
                      context.read<UserState>().showLoginDialog(context)),
            ),
          ],
        ),
        constraints: const BoxConstraints(maxWidth: 1200),
      );
    } else {
      return buildSection2(
        WalletTransactions(poolModel: _poolModel, callback: loadPoolInfo),
        constraints: const BoxConstraints(maxWidth: 1200),
      );
    }
  }

  double calculatePercentage() {
    return (100 * (_poolModel.minTokens + _poolModel.currentTokens)) /
        _poolModel.maxTokens;
  }

  Future<void> loadPoolInfo() async {
    RequestTemplate request = RequestTemplate();
    ResponseTemplate result =
        await API.post(context, APIRoutes.getPoolInfo, request);

    if (result.correct) {
      for (var value in (result.data['pools'] as List)) {
        _poolModel = PoolModel.fromJson(value);
      }

      setState(() {});
    }
  }

  Widget buildSection2(Widget child,
      {double? horizontalPadding,
      double? verticalPadding,
      BoxConstraints? constraints}) {
    return Container(
      constraints: constraints,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 30,
            horizontal: horizontalPadding ?? 34),
        child: child,
      ),
    );
  }
}
