import 'package:blokstaking/router/router_delegate.dart';
import 'package:blokstaking/router/router_information_parser.dart';
import 'package:blokstaking/states/metamask_provider.dart';
import 'package:blokstaking/states/network_state.dart';
import 'package:blokstaking/states/user_state.dart';
import 'package:blokstaking/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants.dart';

void main() {
  setPathUrlStrategy();
  runApp(MultiProvider(providers: [
    // ChangeNotifierProvider(create: (context) => LanguageState()),
    ChangeNotifierProvider(create: (context) => NetworkState()),
    ChangeNotifierProvider(create: (context) => UserState()),
    ChangeNotifierProvider(create: (context) => MetaMaskProvider()..start()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: theme(),
      routerDelegate: MyRouterDelegate(),
      routeInformationParser: MyRouterInfoParser(),
    );
  }
}
