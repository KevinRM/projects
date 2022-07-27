import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants.dart';
import 'router/router_delegate.dart';
import 'router/router_information_parser.dart';
import 'theme.dart';

void main() {
  setPathUrlStrategy();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print("Build main");
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: theme(),
      routerDelegate: MyRouterDelegate(),
      routeInformationParser: MyRouterInfoParser(),
    );
  }
}
