import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/pages/home/components/social_networks_comp.dart';
import 'package:evogalaxy/router/my_router.dart';
import 'package:evogalaxy/router/router_delegate.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class AppBarComp extends StatefulWidget {
  const AppBarComp({Key? key}) : super(key: key);

  @override
  State<AppBarComp> createState() => _AppBarCompState();
}

class _AppBarCompState extends State<AppBarComp> {
  late LanguageState _languageState;
  String _appVersion = "";

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
    _loadAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Constants.appToolbarHeight,
        leadingWidth: 100,
        leading: Container(
          margin: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            UtilitiesFunctions.parseFilePath(Constants.logoPath),
            fit: BoxFit.scaleDown,
          ),
        ),
        actions: getAppBarActions());
  }

  List<Widget> getAppBarActions() {
    List<Widget> widgetsToReturn = [];

    widgetsToReturn.add(TextButton(
        onPressed: () =>
            MyRouterDelegate.of(context).changePage(MyRouterPath.home()),
        child: Text(_languageState.getText(TextKeys.menuHome).toUpperCase())));

    if (!UtilitiesFunctions.isSmallScreen(context)) {
      widgetsToReturn.add(const Flexible(
          child: FittedBox(
              fit: BoxFit.scaleDown, child: SocialNetworks(defaultSize: 18))));
    } else {
      widgetsToReturn.add(PopupMenuButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.menu_outlined),
          ),
          offset: const Offset(-35, 45),
          tooltip: "",
          color: Constants.paletteSelected["light"],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(19),
              bottomLeft: Radius.circular(19),
              bottomRight: Radius.circular(19),
            ),
          ),
          itemBuilder: (BuildContext context) {
            List<PopupMenuItem> items = [];
            items.add(PopupMenuItem(
              enabled: false,
              child: const SocialNetworks(defaultSize: 18),
              onTap: () => UtilitiesFunctions.showSnackbar(
                  context, _languageState.getText(TextKeys.availableSoon)),
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
          }));
    }

    widgetsToReturn.add(
      const CustomSpacer(
        horizontalSpace: Constants.appDefaultSpacing,
      ),
    );

    return widgetsToReturn;
  }

  void _loadAppVersion() async {
    PackageInfo.fromPlatform().then((value) => {
          setState(() {
            _appVersion = value.version;
          })
        });
  }
}
