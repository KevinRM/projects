import 'package:evogalaxy/components/appbar_comp.dart';
import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/components/footer_comp.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  late final LanguageState _languageState;
  final double _maxWidthSection = 1080;

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          child: AppBarComp(),
          preferredSize: Size.fromHeight(Constants.appToolbarHeight)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSection2(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          _languageState
                              .getText(TextKeys.footerPrivacyTitle)
                              .toUpperCase(),
                          style: const TextStyle(fontSize: 24)),
                      const CustomSpacer(
                          verticalSpace: Constants.appDefaultSpacing),
                      Text(_languageState
                              .getText(TextKeys.footerPrivacyLastUpdated) +
                          " 25 Abr 2022"),
                      const CustomSpacer(
                          verticalSpace: Constants.appDefaultSpacing),
                      Text(_languageState.getText(TextKeys.footerPrivacy1)),
                      Text(_languageState.getText(TextKeys.footerPrivacy2)),
                      Text(_languageState.getText(TextKeys.footerPrivacy3)),
                      Text(_languageState.getText(TextKeys.footerPrivacy4)),
                    ],
                  ),
                  constraints: BoxConstraints(maxWidth: _maxWidthSection)),
              // Footer section
              const CustomSpacer(verticalSpace: 50),
              FooterComp(
                languageState: _languageState,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection2(Widget child,
      {double? horizontalPadding,
      double? verticalPadding,
      BoxConstraints? constraints}) {
    return Container(
      constraints: constraints,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 34,
            horizontal: horizontalPadding ?? 34),
        child: child,
      ),
    );
  }
}
