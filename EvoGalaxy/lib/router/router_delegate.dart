import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:evogalaxy/pages/error/error_page.dart';
import 'package:evogalaxy/pages/home/home_page.dart';
import 'package:evogalaxy/pages/noInternet/no_internet_page.dart';
import 'package:evogalaxy/pages/privacy/privacy_page.dart';
import 'package:evogalaxy/pages/splash/splash_page.dart';
import 'package:evogalaxy/pages/terms/terms_page.dart';
import 'package:evogalaxy/router/my_router.dart';
import 'package:evogalaxy/router/transition_page_animation.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/states/network_state.dart';
import 'package:evogalaxy/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRouterDelegate extends RouterDelegate<MyRouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRouterPath> {
  static MyRouterDelegate of(BuildContext context) {
    return Provider.of<MyRouterDelegate>(context, listen: false);
  }

  UserState? _userState;
  NetworkState? _networkState;
  final List<Page> _pages = [];

  MyRouterPath _homePath = MyRouterPath.splash();
  MyRouterPath _currentPath = MyRouterPath.splash();

  @override
  Widget build(BuildContext context) {
    _userState = context.watch<UserState>();
    _userState?.setContext(context, context.read<LanguageState>());
    _userState?.addListener(updateState);
    _networkState = context.watch<NetworkState>();
    _networkState?.addListener(updateState);
    return ChangeNotifierProvider<MyRouterDelegate>.value(
        value: this,
        child: Consumer<MyRouterDelegate>(
            builder: (context, myRouterDelegate, child) {
          return Navigator(
            key: _navigation,
            pages: [getPage(MyRouterPath.splash()), ..._pages],
            onPopPage: (Route<dynamic> route, dynamic result) {
              final didPop = route.didPop(result);
              if (!didPop) {
                return false;
              }
              removePage(route.settings as Page);
              // Set previous page
              if (_pages.isEmpty) {
                _currentPath = Pages.parseRoute(Uri.parse(Pages.splash));
              } else {
                _currentPath = Pages.parseRoute(
                    Uri.parse(_pages.last.name ?? Pages.splash));
              }
              updateState();
              return true;
            },
          );
        }));
  }

  @override
  Future<void> setNewRoutePath(MyRouterPath configuration) async {
    _currentPath = configuration;
    updateState();
  }

  void resetToHome() {
    _currentPath = _homePath;
    updateState();
  }

  void changePage(MyRouterPath path) {
    _currentPath = path;
    updateState();
  }

  void updateState() {
    if (_networkState != null &&
        !_networkState!.isLoading &&
        _networkState!.canContinueOtherScreen) {
      if (_networkState!.connectionStatus == ConnectivityResult.none) {
        _pages.clear();
        _homePath = MyRouterPath.errorNetwork();
        _currentPath = _homePath;
        insertPage(getPage(_currentPath));
      } else if (_userState != null && _userState!.isLogged) {
        // _homePath = MyRouterPath.play();
        // Check if is error page
        if (_currentPath.currentPage == Pages.errorPage) {
          _currentPath = MyRouterPath.errorPage();
          insertPage(getPage(_currentPath));
        } else if (/*_currentPath.currentPage == _homePath.currentPage ||*/
            !_currentPath.currentPage.startsWith(_homePath.currentPage)) {
          // Check if path dont start with '/play/' to clean _pages and redirect to '_homePage'. Example path '/'
          _pages
              .removeWhere((element) => element.name != _homePath.currentPage);
          _currentPath = _homePath;
          insertPage(getPage(_currentPath));
        } else {
          insertPage(getPage(_homePath));
        }
      } else {
        _pages.clear();

        if (_currentPath.currentPage == MyRouterPath.splash().currentPage) {
          _homePath = MyRouterPath.home();
          _currentPath = _homePath;
        }

        // _currentPath = _homePath;
        insertPage(getPage(_currentPath));
      }
    } else {
      _pages.clear();
    }
    notifyListeners();
  }

  Page getPage(MyRouterPath path) {
    switch (path.currentPage) {
      case Pages.splash:
        {
          return const TransitionPageAnimation(
              child: SplashPage(),
              keyParam: ValueKey(Pages.splash),
              nameParam: Pages.splash);
        }
      case Pages.errorNetwork:
        {
          return const TransitionPageAnimation(
              child: NoInternetPage(),
              keyParam: ValueKey(Pages.errorNetwork),
              nameParam: Pages.errorNetwork);
        }
      case Pages.errorPage:
        {
          return const TransitionPageAnimation(
              child: ErrorPage(),
              keyParam: ValueKey(Pages.errorPage),
              nameParam: Pages.errorPage);
        }
      case Pages.home:
        {
          return const TransitionPageAnimation(
              child: HomePage(),
              keyParam: ValueKey(Pages.home),
              nameParam: Pages.home);
        }
      case Pages.terms:
        {
          return const TransitionPageAnimation(
              child: TermsPage(),
              keyParam: ValueKey(Pages.terms),
              nameParam: Pages.terms);
        }
      case Pages.privacy:
        {
          return const TransitionPageAnimation(
              child: PrivacyPage(),
              keyParam: ValueKey(Pages.privacy),
              nameParam: Pages.privacy);
        }
      default:
        {
          return const TransitionPageAnimation(
              child: ErrorPage(),
              keyParam: ValueKey(Pages.errorPage),
              nameParam: Pages.errorPage);
        }
    }
  }

  void insertPage(Page page) {
    int index = _pages.indexWhere((element) => element.key == page.key);
    if (index != -1) {
      if (index + 1 < _pages.length) {
        _pages.removeRange(index + 1, _pages.length);
      }
    } else {
      _pages.add(page);
    }
    // print("Pages -> Insert index: " +
    //     index.toString() +
    //     " Size array: " +
    //     _pages.length.toString());
  }

  void removePage(Page page) {
    _pages.remove(page);
  }

  final GlobalKey<NavigatorState> _navigation = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigation;

  @override
  MyRouterPath get currentConfiguration {
    return _currentPath;
  }
}
