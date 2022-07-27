import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_mind/utilities/utilities.dart';
import 'package:provider/provider.dart';

import '../../../api/models/user.model.dart';
import '../../../constants.dart';
import '../../../states/language_state.dart';
import '../../../states/user_state.dart';

class BannerVerifyEmail extends StatefulWidget {
  const BannerVerifyEmail({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerVerifyEmail> createState() => _BannerVerifyEmailState();
}

class _BannerVerifyEmailState extends State<BannerVerifyEmail> {
  late LanguageState _languageState;
  late UserModel _userModel;

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
    _userModel = context.read<UserState>().userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: _languageState.getText(TextKeys.txtBannerVerifyAccount)),
        TextSpan(
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            text: " " +
                UtilitiesFunctions.getDateFormatLocale().format(
                    DateTime.parse(_userModel.createdAt!)
                        .add(Constants.deleteAccountNoVerification)) +
                "   "),
        TextSpan(
            text: _languageState.getText(TextKeys.btnVerify),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context
                  .read<UserState>()
                  .sendVerificationEmail(context, _languageState),
            style: TextStyle(
                color: Constants.paletteSelected["light"],
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                fontSize: 16)),
      ]),
      style: const TextStyle(fontSize: 12),
    );
  }
}
