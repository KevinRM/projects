import 'package:flutter/material.dart';
import 'package:my_mind/constants.dart';
import 'package:my_mind/router/my_router.dart';
import 'package:my_mind/router/router_page_manager.dart';
import 'package:my_mind/states/language_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late LanguageState _languageState;
  final double maxWidthCard = 452;

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Constants.appPaddingScreenBorder),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                            onPressed: () => RouterPageManager.of(context)
                                .goToPage(MyRouterPath.signin()),
                            child: Text(
                                _languageState.getText(TextKeys.btnSignIn))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
