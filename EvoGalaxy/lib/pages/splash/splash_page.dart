import 'package:evogalaxy/components/custom_spacer.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.appDefaultPadding),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: SvgPicture.asset(
                  UtilitiesFunctions.parseFilePath(Constants.logoPath),
                  fit: BoxFit.scaleDown,
                  height: 200,
                ),
              ),
            ),
            const CustomSpacer(verticalSpace: Constants.appDefaultSpacing),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.appDefaultPadding),
              child: SizedBox(width: 200, child: LinearProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
