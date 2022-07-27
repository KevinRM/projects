import 'package:blokstaking/router/my_router.dart';
import 'package:flutter/material.dart';

class MyRouterInfoParser extends RouteInformationParser<MyRouterPath> {
  @override
  Future<MyRouterPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    // Parse RouteInformation (browser) to currentConfiguration (delegate)
    final uri = Uri.parse(routeInformation.location ?? "");
    return Pages.parseRoute(uri);
  }

  @override
  RouteInformation? restoreRouteInformation(MyRouterPath configuration) {
    // Parse currentConfiguration (delegate) to RouteInformation (browser)
    if (configuration.currentPage.isNotEmpty) {
      return RouteInformation(location: configuration.currentPage);
    }

    return null;
  }
}
