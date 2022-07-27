import 'package:flutter/material.dart';
import 'package:my_mind/shared_components/custom_spacer.dart';
import 'package:my_mind/utilities/size_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../../api/models/user.model.dart';
import '../../../constants.dart';
import '../../../shared_components/icon_with_text.dart';
import '../../../states/language_state.dart';
import '../../../states/user_state.dart';
import '../../../utilities/utilities.dart';

class AppTopBar extends StatefulWidget {
  const AppTopBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AppTopBar> createState() => _AppTopBarState();
}

class _AppTopBarState extends State<AppTopBar> {
  late LanguageState _languageState;
  late UserModel _userModel;
  String _appVersion = "";

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
    _loadAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    _userModel = context.select((UserState us) => us.userModel);
    return AppBar(
      automaticallyImplyLeading: false,
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            Image.asset(UtilitiesFunctions.parseFilePath(Constants.logoPath),
                height: Constants.appToolbarHeight - 12),
            const CustomSpacer(horizontalSpace: 9),
            const Text(
              Constants.appName,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      actions: [
        PopupMenuButton(
            child: IconWithText(
                icon: Icons.account_circle_outlined,
                text: SizeConfig.isSmallScreen(context)
                    ? ""
                    : _userModel.getDisplayName()),
            offset: const Offset(-35, 45),
            tooltip: "",
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Constants.appDefaultBorderRadius),
                bottomLeft: Radius.circular(Constants.appDefaultBorderRadius),
                bottomRight: Radius.circular(Constants.appDefaultBorderRadius),
              ),
            ),
            itemBuilder: (BuildContext context) {
              List<PopupMenuItem> items = [];
              if (SizeConfig.isSmallScreen(context)) {
                items.add(
                  PopupMenuItem(
                    enabled: false,
                    height: 12,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            _userModel.getDisplayName(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                );
              }
              items.add(PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.portrait),
                  title: Text(_languageState.getText(TextKeys.profileText)),
                ),
                onTap: () => UtilitiesFunctions.showSnackbar(
                    context, _languageState.getText(TextKeys.txtAvailableSoon)),
              ));
              items.add(PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(_languageState.getText(TextKeys.signOutText)),
                ),
                onTap: () => context.read<UserState>().signOut(),
              ));
              items.add(PopupMenuItem(
                enabled: false,
                height: 12,
                child: Column(
                  children: [
                    const Divider(),
                    Center(
                      child: Text(
                        _appVersion,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ));

              return items;
            }),
        const CustomSpacer(horizontalSpace: Constants.appPaddingScreenBorder),
      ],
    );
  }

  void _loadAppVersion() async {
    PackageInfo.fromPlatform().then((value) => {
          setState(() {
            _appVersion = Constants.appNameVersion + " " + value.version;
          })
        });
  }
}
