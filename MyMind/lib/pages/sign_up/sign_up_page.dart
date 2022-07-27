import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_mind/api/models/user.model.dart';
import 'package:my_mind/constants.dart';
import 'package:my_mind/router/my_router.dart';
import 'package:my_mind/router/router_page_manager.dart';
import 'package:my_mind/shared_components/custom_divider.dart';
import 'package:my_mind/shared_components/custom_spacer.dart';
import 'package:my_mind/states/language_state.dart';
import 'package:my_mind/states/user_state.dart';
import 'package:my_mind/utilities/size_config.dart';
import 'package:provider/provider.dart';

import '../../utilities/utilities.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late LanguageState _languageState;
  final UserModel _userModel = UserModel();
  String _emailConfirm = "";
  String _pass = "";
  String _passConfirm = "";

  bool _firstInput = true;
  bool _isSaving = false;

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
                                  const CustomSpacer(verticalSpace: 14),
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
                                    _languageState.getText(TextKeys.txtSignUp),
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
                      const CustomSpacer(verticalSpace: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          _languageState.getText(TextKeys.txtSignUpDescription),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 12,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const CustomSpacer(verticalSpace: 8),
                              // Email
                              UtilitiesFunctions.buildTextFormField(
                                _languageState,
                                TextInputType.emailAddress,
                                TextKeys.txtEmail,
                                "",
                                isRequired: true,
                                onSaved: (String? value) =>
                                    _userModel.email = value!,
                                onChange: (value) {
                                  _userModel.email = value;
                                  if (!_firstInput) {
                                    _formKey.currentState!.validate();
                                  }
                                },
                                onFieldSubmitted: (value) async {
                                  await sendRegister();
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return _languageState
                                        .getText(TextKeys.errRequiredField);
                                  } else if (!Constants.emailValidatorRegExp
                                      .hasMatch(value)) {
                                    return _languageState
                                        .getText(TextKeys.errInvalidEmail);
                                  } else if (_userModel.email !=
                                      _emailConfirm) {
                                    return _languageState
                                        .getText(TextKeys.errEmailsDifferents);
                                  }
                                  return null;
                                },
                              ),
                              // Email confirm
                              UtilitiesFunctions.buildTextFormField(
                                _languageState,
                                TextInputType.emailAddress,
                                TextKeys.txtConfirmEmail,
                                "",
                                isRequired: true,
                                onSaved: (String? value) =>
                                    _emailConfirm = value!,
                                onChange: (value) {
                                  _emailConfirm = value;
                                  if (!_firstInput) {
                                    _formKey.currentState!.validate();
                                  }
                                },
                                onFieldSubmitted: (value) async {
                                  await sendRegister();
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return _languageState
                                        .getText(TextKeys.errRequiredField);
                                  } else if (!Constants.emailValidatorRegExp
                                      .hasMatch(value)) {
                                    return _languageState
                                        .getText(TextKeys.errInvalidEmail);
                                  } else if (_userModel.email !=
                                      _emailConfirm) {
                                    return _languageState
                                        .getText(TextKeys.errEmailsDifferents);
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
                                  _pass = value;
                                  if (!_firstInput) {
                                    _formKey.currentState!.validate();
                                  }
                                },
                                onFieldSubmitted: (value) async {
                                  await sendRegister();
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return _languageState
                                        .getText(TextKeys.errRequiredField);
                                  } else if (value.length <=
                                      Constants.minPassLength) {
                                    return _languageState
                                        .getText(TextKeys.errorPassShort);
                                  } else if (_pass != _passConfirm) {
                                    return _languageState
                                        .getText(TextKeys.errorPassDifferents);
                                  }
                                  return null;
                                },
                              ),
                              // Password confirm
                              UtilitiesFunctions.buildTextFormField(
                                _languageState,
                                TextInputType.visiblePassword,
                                TextKeys.txtConfirmPassword,
                                "",
                                isRequired: true,
                                obscureText: true,
                                maxLines: 1,
                                onSaved: (String? value) =>
                                    _passConfirm = value!,
                                onChange: (value) {
                                  _passConfirm = value;
                                  if (!_firstInput) {
                                    _formKey.currentState!.validate();
                                  }
                                },
                                onFieldSubmitted: (value) async {
                                  await sendRegister();
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return _languageState
                                        .getText(TextKeys.errRequiredField);
                                  } else if (value.length <=
                                      Constants.minPassLength) {
                                    return _languageState
                                        .getText(TextKeys.errorPassShort);
                                  } else if (_pass != _passConfirm) {
                                    return _languageState
                                        .getText(TextKeys.errorPassDifferents);
                                  }
                                  return null;
                                },
                              ),
                              const CustomSpacer(verticalSpace: 28),
                              _isSaving
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: (() => sendRegister()),
                                      child: Text(_languageState
                                          .getText(TextKeys.btnSignUp))),
                              const CustomSpacer(verticalSpace: 28),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: _languageState.getText(
                                              TextKeys.txtAlreadyHaveAccount) +
                                          " "),
                                  TextSpan(
                                      text: _languageState
                                          .getText(TextKeys.btnSignIn),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => RouterPageManager.of(
                                                context)
                                            .goToPage(MyRouterPath.signin()),
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

  Future<void> sendRegister() async {
    setState(() {
      _firstInput = false;
      _isSaving = true;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String err =
          await context.read<UserState>().signUpUser(_userModel.email!, _pass);

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
