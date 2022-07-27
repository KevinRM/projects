import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_mind/constants.dart';
import 'package:my_mind/router/my_router.dart';
import 'package:my_mind/router/router_page_manager.dart';
import 'package:my_mind/shared_components/custom_divider.dart';
import 'package:my_mind/shared_components/custom_spacer.dart';
import 'package:my_mind/states/language_state.dart';
import 'package:my_mind/utilities/size_config.dart';
import 'package:provider/provider.dart';

import '../../states/user_state.dart';
import '../../utilities/utilities.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  late LanguageState _languageState;

  bool _firstInput = true;
  bool _isSaving = false;
  String _email = "";
  String _pass = "";

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.appPaddingScreenBorder),
              child: Container(
                constraints: SizeConfig.isSmallScreen(context)
                    ? null
                    : const BoxConstraints(maxWidth: 400),
                child: Card(
                  child: Column(
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Constants.paletteSelected["medium"],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(35),
                                    bottomRight: Radius.circular(35)),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    UtilitiesFunctions.parseFilePath(
                                        Constants.logoPath),
                                    height: 200,
                                    width: 175,
                                  ),
                                  Text(
                                    Constants.appName,
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Constants.paletteSelected["dark"]),
                                  ),
                                  const CustomSpacer(verticalSpace: 10),
                                  const CustomDivider(),
                                  const CustomSpacer(verticalSpace: 10),
                                  Text(
                                    _languageState.getText(TextKeys.txtSignIn),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            Constants.paletteSelected["text"]),
                                  ),
                                  const CustomSpacer(verticalSpace: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const CustomSpacer(verticalSpace: 10),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const CustomSpacer(verticalSpace: 20),
                              // Email
                              UtilitiesFunctions.buildTextFormField(
                                _languageState,
                                TextInputType.emailAddress,
                                TextKeys.txtEmail,
                                "",
                                isRequired: true,
                                onSaved: (String? value) => _email = value!,
                                onChange: (value) {
                                  if (!_firstInput) {
                                    _formKey.currentState!.validate();
                                  }
                                },
                                onFieldSubmitted: (value) async {
                                  await sendLogin();
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return _languageState
                                        .getText(TextKeys.errRequiredField);
                                  } else if (!Constants.emailValidatorRegExp
                                      .hasMatch(value)) {
                                    return _languageState
                                        .getText(TextKeys.errInvalidEmail);
                                  }
                                  return null;
                                },
                              ),
                              // Password
                              UtilitiesFunctions.buildTextFormField(
                                _languageState,
                                TextInputType.visiblePassword,
                                TextKeys.txtPassword,
                                "",
                                isRequired: true,
                                obscureText: true,
                                maxLines: 1,
                                onSaved: (String? value) => _pass = value!,
                                onChange: (value) {
                                  if (!_firstInput) {
                                    _formKey.currentState!.validate();
                                  }
                                },
                                onFieldSubmitted: (value) async {
                                  await sendLogin();
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return _languageState
                                        .getText(TextKeys.errRequiredField);
                                  } else if (value.length <=
                                      Constants.minPassLength) {
                                    return _languageState
                                        .getText(TextKeys.errorPassShort);
                                  }
                                  return null;
                                },
                              ),
                              const CustomSpacer(verticalSpace: 28),
                              _isSaving
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: (() => sendLogin()),
                                      child: Text(_languageState
                                          .getText(TextKeys.btnSignIn))),
                              const CustomSpacer(verticalSpace: 28),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: _languageState.getText(
                                              TextKeys.txtForgotPassword) +
                                          " "),
                                  TextSpan(
                                      text: _languageState
                                          .getText(TextKeys.btnRemember),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            UtilitiesFunctions.showAlertDialog(
                                                context,
                                                _languageState.getText(TextKeys
                                                    .txtAvailableSoonTitle),
                                                _languageState.getText(
                                                    TextKeys.txtAvailableSoon)),
                                      style: TextStyle(
                                        color:
                                            Constants.paletteSelected["light"],
                                        fontStyle: FontStyle.italic,
                                      )),
                                ]),
                                style: const TextStyle(fontSize: 12),
                              ),
                              const CustomSpacer(verticalSpace: 8),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: _languageState.getText(
                                              TextKeys.txtNotHaveAccount) +
                                          " "),
                                  TextSpan(
                                      text: _languageState
                                          .getText(TextKeys.btnSignUp),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => RouterPageManager.of(
                                                context)
                                            .goToPage(MyRouterPath.signup()),
                                      style: TextStyle(
                                        color:
                                            Constants.paletteSelected["light"],
                                        fontStyle: FontStyle.italic,
                                      )),
                                ]),
                                style: const TextStyle(fontSize: 12),
                              ),
                              const CustomSpacer(verticalSpace: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendLogin() async {
    setState(() {
      _firstInput = false;
      _isSaving = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String err = await context.read<UserState>().signInUser(_email, _pass);

      if (err != "") {
        UtilitiesFunctions.showAlertDialog(
            context, "Error", _languageState.pareseErrorTxt(err));
      }
    } else {
      UtilitiesFunctions.showSnackbar(
          context, _languageState.getText(TextKeys.errFormFields));
    }
    setState(() {
      _isSaving = false;
    });
  }
}
