import 'package:flutter/material.dart';

import 'my_router.dart';

class MyRouterInfoParser extends RouteInformationParser<MyRouterPath> {
  @override
  // Para parsear las rutas entrantes ( RouteInformation ) y convertirlo en una tipo definido por el usuario
  Future<MyRouterPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    // Parse RouteInformation (browser) to currentConfiguration (delegate)
    return MyRouterPath.parseUrl(routeInformation.location ?? "");
  }

  @override
  // Dice a la plataforma (browser por ejemplo) cual es el path en el que está
  RouteInformation? restoreRouteInformation(MyRouterPath configuration) {
    // Parse currentConfiguration (delegate) to RouteInformation (browser)
    if (configuration.pagePath.isNotEmpty) {
      return RouteInformation(location: configuration.pagePath);
    }

    return null;
  }
}
