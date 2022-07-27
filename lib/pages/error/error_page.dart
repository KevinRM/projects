import 'package:flutter/material.dart';
import 'package:my_mind/router/router_page_manager.dart';

import '../../shared_components/custom_spacer.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FittedBox(
                                child: Text(
                              "Error 404: Page does not exist",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            )),
                            const CustomSpacer(
                              verticalSpace: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                RouterPageManager routerManager =
                                    RouterPageManager.of(context);
                                routerManager
                                    .goToPage(routerManager.defaultPage);
                              },
                              child: const Text("Go home"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
