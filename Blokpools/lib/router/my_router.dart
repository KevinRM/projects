class Pages {
  static const String splash = "/";
  static const String errorNetwork = splash + "errornetwork";
  static const String errorPage = splash + "404";
  static const String home = splash + "pool";

  static MyRouterPath parseRoute(Uri uri) {
    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return MyRouterPath.splash();
    }

    // Handle '/page'
    if (uri.pathSegments.length == 1) {
      final segment = "/" + uri.pathSegments.elementAt(0);
      switch (segment) {
        case Pages.home:
          return MyRouterPath.home();
        case Pages.errorNetwork:
          return MyRouterPath.errorNetwork();
      }
    }

    return MyRouterPath.errorPage();
  }
}

class MyRouterPath {
  final String currentPage;
  dynamic parameter;

  MyRouterPath.splash() : currentPage = Pages.splash;
  MyRouterPath.errorNetwork() : currentPage = Pages.errorNetwork;
  MyRouterPath.errorPage() : currentPage = Pages.errorPage;
  MyRouterPath.home() : currentPage = Pages.home;
}
