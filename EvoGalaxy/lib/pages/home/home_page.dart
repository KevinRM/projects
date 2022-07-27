import 'package:evogalaxy/api/api_communication.dart';
import 'package:evogalaxy/api/models/analytics.model.dart';
import 'package:evogalaxy/api/request_template.dart';
import 'package:evogalaxy/api/routes.dart';
import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/pages/home/components/aboutus_comp.dart';
import 'package:evogalaxy/pages/home/components/announcement_banner_comp.dart';
import 'package:evogalaxy/components/appbar_comp.dart';
import 'package:evogalaxy/components/footer_comp.dart';
import 'package:evogalaxy/pages/home/components/donation_comp.dart';
import 'package:evogalaxy/pages/home/components/faq_comp.dart';
import 'package:evogalaxy/pages/home/components/features_comp.dart';
import 'package:evogalaxy/pages/home/components/header_comp.dart';
import 'package:evogalaxy/pages/home/components/partners_comp.dart';
import 'package:evogalaxy/pages/home/components/roadmap_comp.dart';
import 'package:evogalaxy/pages/home/components/token_utility_comp.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final LanguageState _languageState;
  final double _maxWidthSection = 1280;
  final double _tabsPadding = 12;
  TextKeys _tabSelected = TextKeys.projectFeaturesTitle;

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
    API.post(
        null,
        null,
        APIRoutes.analytics,
        RequestTemplate(
            data: Analytics(
                    typeAnalytics: TYPE_ANALYTICS.pageView.name, value: "Home")
                .toJson()));
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
              // Announcement banner
              AnnouncementBannerComp(
                languageState: _languageState,
              ),
              // Header section
              HeaderComp(languageState: _languageState),
              // Tap bar
              buildSection(Container(
                color: Constants.paletteSelected["medium"],
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    Container(
                      color: _tabSelected == TextKeys.projectFeaturesTitle
                          ? Constants.paletteSelected["light"]
                          : null,
                      child: TextButton(
                          onPressed: () => setState(() =>
                              _tabSelected = TextKeys.projectFeaturesTitle),
                          child: Padding(
                            padding: EdgeInsets.all(_tabsPadding),
                            child: Text(_languageState
                                .getText(TextKeys.projectFeaturesTitle)),
                          )),
                    ),
                    Container(
                      color: _tabSelected == TextKeys.roadmapTitle
                          ? Constants.paletteSelected["light"]
                          : null,
                      child: TextButton(
                          onPressed: () => setState(
                              () => _tabSelected = TextKeys.roadmapTitle),
                          child: Padding(
                            padding: EdgeInsets.all(_tabsPadding),
                            child: Text(
                                _languageState.getText(TextKeys.roadmapTitle)),
                          )),
                    ),
                    Container(
                      color: _tabSelected == TextKeys.tokenUtilityTitle
                          ? Constants.paletteSelected["light"]
                          : null,
                      child: TextButton(
                          onPressed: () => setState(
                              () => _tabSelected = TextKeys.tokenUtilityTitle),
                          child: Padding(
                            padding: EdgeInsets.all(_tabsPadding),
                            child: Text(_languageState
                                .getText(TextKeys.tokenUtilityTitle)),
                          )),
                    ),
                    Container(
                      color: _tabSelected == TextKeys.partnersTitle
                          ? Constants.paletteSelected["light"]
                          : null,
                      child: TextButton(
                          onPressed: () => setState(
                              () => _tabSelected = TextKeys.partnersTitle),
                          child: Padding(
                            padding: EdgeInsets.all(_tabsPadding),
                            child: Text(
                                _languageState.getText(TextKeys.partnersTitle)),
                          )),
                    ),
                    Container(
                      color: _tabSelected == TextKeys.faqTitle
                          ? Constants.paletteSelected["light"]
                          : null,
                      child: TextButton(
                          onPressed: () =>
                              setState(() => _tabSelected = TextKeys.faqTitle),
                          child: Padding(
                            padding: EdgeInsets.all(_tabsPadding),
                            child:
                                Text(_languageState.getText(TextKeys.faqTitle)),
                          )),
                    ),
                    Container(
                      color: _tabSelected == TextKeys.aboutUsTitle
                          ? Constants.paletteSelected["light"]
                          : null,
                      child: TextButton(
                          onPressed: () => setState(
                              () => _tabSelected = TextKeys.aboutUsTitle),
                          child: Padding(
                            padding: EdgeInsets.all(_tabsPadding),
                            child: Text(
                                _languageState.getText(TextKeys.aboutUsTitle)),
                          )),
                    ),
                    Container(
                      color: _tabSelected == TextKeys.donationTitle
                          ? Constants.paletteSelected["light"]
                          : null,
                      child: TextButton(
                          onPressed: () => setState(
                              () => _tabSelected = TextKeys.donationTitle),
                          child: Padding(
                            padding: EdgeInsets.all(_tabsPadding),
                            child: Text(
                                _languageState.getText(TextKeys.donationTitle)),
                          )),
                    ),
                  ],
                ),
              )),
              getTabContent(),
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

  Widget getTabContent() {
    switch (_tabSelected) {
      case TextKeys.roadmapTitle:
        // Roadmap section
        return buildSection(RoadmapComp(languageState: _languageState),
            constraints: BoxConstraints(maxWidth: _maxWidthSection));
      case TextKeys.partnersTitle:
        // Partners section
        return buildSection(PartnersComp(languageState: _languageState),
            constraints: BoxConstraints(maxWidth: _maxWidthSection));
      case TextKeys.aboutUsTitle:
        // About us section
        return buildSection(AboutusComp(languageState: _languageState),
            constraints: BoxConstraints(maxWidth: _maxWidthSection));
      case TextKeys.donationTitle:
        // Donation section
        return buildSection(DonationComp(languageState: _languageState),
            constraints: BoxConstraints(maxWidth: _maxWidthSection));
      case TextKeys.faqTitle:
        // FAQ section
        return buildSection(FaqComp(languageState: _languageState),
            constraints: BoxConstraints(maxWidth: _maxWidthSection));
      case TextKeys.tokenUtilityTitle:
        // Token utility section
        return buildSection(TokenUtilityComp(languageState: _languageState),
            constraints: BoxConstraints(maxWidth: _maxWidthSection));
      default:
        // Features section
        return buildSection(FeaturesComp(languageState: _languageState));
    }
  }

  Widget buildSection(Widget child,
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
