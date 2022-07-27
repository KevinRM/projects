import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_mind/router/my_router.dart';
import 'package:my_mind/states/network_state.dart';
import 'package:my_mind/states/user_state.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class RouterPageManager extends ChangeNotifier {
  static RouterPageManager of(BuildContext context) =>
      Provider.of<RouterPageManager>(context, listen: false);

  MyRouterPath defaultPage = MyRouterPath.home();
  final List<Page> _pages = [];
  List<Page> get pages => List.unmodifiable(_pages);
  MyRouterPath get currentPath => MyRouterPath.parseUrl(_pages.last.name ?? "");

  // Splash
  bool _canContinueOtherScreen = false;
  bool _checkingNetwork = true;
  late Timer _timerReference;

  // Middlewares
  late UserState _userState;

  RouterPageManager() {
    _pages.add(defaultPage.page);
    _timerReference = Timer(Constants.splashDuration, () {
      _canContinueOtherScreen = true;
      goToPage(null);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timerReference.cancel();
  }

  void goToPage(MyRouterPath? newPage) {
    if (newPage != null) {
      // If the current page is the default page, remove all others
      if (newPage.pagePath == defaultPage.pagePath) {
        _pages.removeWhere((element) => element.name != newPage.pagePath);
      } else if (newPage.pagePath == MyRouterPath.errorPage().pagePath) {
        if (!stackContainPage(newPage)) {
          _pages.add(newPage.page);
        }
      } else {
        // If the new page is unique and it is already in the stack, remove it
        // and subsequent pages. Then, insert it other time for the case that
        // it receive parameters or other config
        if (newPage.unique &&
            stackContainPage(newPage) &&
            _pages.last.name != newPage.pagePath) {
          _pages.removeRange(
              _pages.indexWhere((element) => element.name == newPage.pagePath),
              _pages.length);
        }
        _pages.add(newPage.page);
      }
    }

    // Control splash page
    if (!_canContinueOtherScreen || _checkingNetwork) {
      _pages.add(MyRouterPath.splash().page);
    } else {
      if (stackContainPage(MyRouterPath.splash())) {
        _pages.removeWhere(
            (element) => element.name == MyRouterPath.splash().pagePath);
      }

      // User middleware to check session
      _checkUserStateMiddleware();
    }

    // Prevenimos que quede vacío el Stack
    if (_pages.isEmpty) {
      _pages.add(defaultPage.page);
    }
    print(newPage?.pagePath);
    notifyListeners();
  }

  void didPop(Page page) {
    _pages.remove(page);
    notifyListeners();
  }

  Future<void> setNewRoutePath(MyRouterPath configuration) async {
    goToPage(configuration);
  }

  bool stackContainPage(MyRouterPath page) {
    return _pages.indexWhere((element) => element.name == page.pagePath) != -1;
  }

  void setMiddlewares(UserState userState) => _userState = userState;

  VoidCallback errorNetwork(NetworkState networkState) {
    return () {
      if (networkState.connectionStatus == ConnectivityResult.none) {
        goToPage(MyRouterPath.errorNetwork());
      } else if (stackContainPage(MyRouterPath.errorNetwork())) {
        _pages.removeWhere(
            (element) => element.name == MyRouterPath.errorNetwork().pagePath);
        goToPage(null);
      }
      _checkingNetwork = false;
    };
  }

  VoidCallback changedUserState(UserState userState) {
    return () {
      if (!_canContinueOtherScreen || _checkingNetwork) {
        Future.delayed(const Duration(seconds: 1), (() {
          changedUserState(userState);
        }));
      } else {
        if (_userState.isLogged &&
            !currentPath.pagePath.startsWith(MyRouterPath.app().pagePath)) {
          goToPage(MyRouterPath.app());
        }
        _checkUserStateMiddleware();
      }
    };
  }

  void _checkUserStateMiddleware() {
    if (!_userState.isLogged &&
        currentPath.pagePath.startsWith(MyRouterPath.app().pagePath)) {
      // Si no esta logeado y esta dentro de la seccion que necesita login, redireccionamos a login
      goToPage(MyRouterPath.signin());
    } else if (_userState.isLogged) {
      defaultPage = MyRouterPath.app();
    } else {
      defaultPage = MyRouterPath.home();
    }
  }
}
