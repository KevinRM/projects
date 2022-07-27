import 'package:flutter/material.dart';
import 'package:my_mind/api/models/user.model.dart';
import 'package:my_mind/constants.dart';
import 'package:my_mind/pages/app/notes/notes_page.dart';
import 'package:my_mind/pages/app/reminders/reminders_page.dart';
import 'package:my_mind/shared_components/icon_with_text.dart';
import 'package:provider/provider.dart';

import '../../states/language_state.dart';
import '../../states/user_state.dart';
import 'components/app_top_bar.dart';
import 'components/banner_verify_email.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with SingleTickerProviderStateMixin {
  late LanguageState _languageState;
  TabController? _tabController;
  late UserModel _userModel;

  final List<Widget> _screens = [const NotesPage(), const RemindersPage()];

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
    _tabController = TabController(length: _screens.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _userModel = context.select((UserState us) => us.userModel);
    return SafeArea(
      child: Scaffold(
          appBar: const PreferredSize(
            child: AppTopBar(),
            preferredSize: Size.fromHeight(Constants.appToolbarHeight),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildBannerSection(),
                    Padding(
                        padding: const EdgeInsets.all(
                            Constants.appPaddingScreenBorder),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: buildBody(),
                        )),
                  ]),
            ),
          )),
    );
  }

  Widget buildBannerSection() {
    List<Widget> listToReturn = [];
    if (_userModel.emailVerified != null && !_userModel.emailVerified!) {
      listToReturn.add(
        const BannerVerifyEmail(),
      );
    }
    return listToReturn.isEmpty
        ? const SizedBox()
        : Container(
            color: Constants.paletteSelected["medium"],
            padding: const EdgeInsets.all(Constants.appPaddingScreenBorder),
            child: Column(
              children: listToReturn,
            ),
          );
  }

  List<Widget> buildBody() {
    List<Widget> listToReturn = [];
    listToReturn.add(Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Constants.paletteSelected["dark"]!, width: 5))),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 350),
              decoration: BoxDecoration(
                  color: Constants.paletteSelected["dark"]!,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Constants.appDefaultBorderRadius),
                    topRight: Radius.circular(Constants.appDefaultBorderRadius),
                  )),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TabBar(
                    controller: _tabController,
                    labelPadding: const EdgeInsets.only(bottom: 3.0, top: 18.0),
                    indicator: BoxDecoration(
                        color: Constants.paletteSelected["background"],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                                Constants.appDefaultBorderRadius),
                            topRight: Radius.circular(
                                Constants.appDefaultBorderRadius))),
                    indicatorPadding:
                        const EdgeInsets.only(top: 10, bottom: -5),
                    onTap: (index) => setState(() {}),
                    tabs: [
                      IconWithText(
                        icon: Icons.notes_outlined,
                        text: _languageState.getText(TextKeys.txtNotes),
                        vertical: true,
                      ),
                      IconWithText(
                        icon: Icons.timer_outlined,
                        text: _languageState.getText(TextKeys.txtReminders),
                        vertical: true,
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    ));

    listToReturn.add(Padding(
      padding: const EdgeInsets.all(Constants.appPaddingScreenBorder),
      child: _screens[_tabController!.index],
    ));

    // Add ads
    // if (_showAds) {
    //   listToReturn.add(
    //     Container(
    //       height: _bannerAdHeight,
    //       padding: EdgeInsets.all(_bannerAdHeight > 0 ? 10.0 : 0.0),
    //       margin: EdgeInsets.only(bottom: 20.0),
    //       child: NativeAdmob(
    //         adUnitID: cBannerAdUnitID,
    //         loading: Container(),
    //         controller: _nativeAdController,
    //         numberAds: 3,
    //         error: Container(),
    //         type: NativeAdmobType.banner,
    //       ),
    //     ),
    //   );
    // }

    return listToReturn;
  }
}
