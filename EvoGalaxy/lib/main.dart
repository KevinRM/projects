import 'package:evogalaxy/router/router_delegate.dart';
import 'package:evogalaxy/router/router_information_parser.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/states/network_state.dart';
import 'package:evogalaxy/states/user_state.dart';
import 'package:evogalaxy/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LanguageState()),
    ChangeNotifierProvider(create: (context) => NetworkState()),
    ChangeNotifierProvider(create: (context) => UserState()),
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
    return Consumer<LanguageState>(
      builder: (context, languageState, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          theme: theme(),
          routerDelegate: MyRouterDelegate(),
          routeInformationParser: MyRouterInfoParser(),
        );
      },
    );
  }
}
