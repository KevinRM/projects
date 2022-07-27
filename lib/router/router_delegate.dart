import 'package:flutter/material.dart';
import 'package:my_mind/router/router_page_manager.dart';
import 'package:my_mind/states/network_state.dart';
import 'package:my_mind/states/user_state.dart';
import 'package:my_mind/utilities/size_config.dart';
import 'package:provider/provider.dart';
import '../states/language_state.dart';
import 'my_router.dart';
import 'transition_page_animation.dart';

// References
// https://www.youtube.com/watch?v=FBoAXUkHu44
// https://github.com/orestesgaolin/navigator_20_example/blob/master/lib/main_router.dart

class MyRouterDelegate extends RouterDelegate<MyRouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRouterPath> {
  MyRouterDelegate() {
    _pageManager.addListener(notifyListeners);
    _networkState.addListener(_pageManager.errorNetwork(_networkState));
    _userState.addListener(_pageManager.changedUserState(_userState));
    _pageManager.setMiddlewares(_userState);
  }

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final RouterPageManager _pageManager = RouterPageManager();
  final NetworkState _networkState = NetworkState();
  final UserState _userState = UserState();
  final LanguageState _languageState = LanguageState();

  @override
  Widget build(BuildContext context) {
    _userState.setContext(context, _languageState);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _languageState),
          ChangeNotifierProvider.value(value: _pageManager),
          ChangeNotifierProvider.value(value: _userState),
        ],
        child:
            Consumer<RouterPageManager>(builder: (context, pageManager, child) {
          print("== Pages stack: " + pageManager.pages.length.toString());
          for (var element in pageManager.pages) {
            print(element.name);
          }
          print("====");
          return Navigator(
            key: _navigatorKey,
            pages: SizeConfig.incompatibleScreen(context)
                ? [
                    TransitionPageAnimation(
                        child: Scaffold(
                          body: Center(
                            child: Text(
                              _languageState
                                  .getText(TextKeys.errIncompatibleScreenSize),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        keyParam: UniqueKey(),
                        nameParam: "",
                        durationParamMS: 0)
                  ]
                : List.of(pageManager.pages),
            onPopPage: (Route<dynamic> route, dynamic result) {
              final didPop = route.didPop(result);
              if (!didPop) {
                return false;
              }
              _pageManager.didPop(route.settings as Page);
              return true;
            },
          );
        }));
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  // Cuando una nueva ruta ha sido llamada a la aplicación
  // Creo que recibe desde parseRouteInformation
  Future<void> setNewRoutePath(MyRouterPath configuration) async =>
      await _pageManager.setNewRoutePath(configuration);

  @override
  //Para poder mostrar el path correcto en una URL
  MyRouterPath get currentConfiguration => _pageManager.currentPath;
}
