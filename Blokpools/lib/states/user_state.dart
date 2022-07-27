import 'dart:async';
import 'package:blokstaking/constants.dart';
import 'package:blokstaking/shared_components/custom_elevated_button.dart';
import 'package:blokstaking/shared_components/custom_spacer.dart';
import 'package:blokstaking/states/metamask_provider.dart';
import 'package:blokstaking/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState with ChangeNotifier {
  BuildContext? _context;
  bool isLogged = false;

  void setContext(BuildContext contx) {
    _context = contx;
  }

  void showLoginDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierColor: const Color(0xffdcd1e8).withOpacity(0.67),
        builder: (_) => AlertDialog(
              elevation: 0,
              contentPadding: const EdgeInsets.all(0),
              backgroundColor: Constants.paletteSelected["dark"],
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Constants.paletteSelected["light"]!, width: 1.5),
                  borderRadius: BorderRadius.circular(12)),
              content: Container(
                constraints: const BoxConstraints(maxWidth: 512),
                width: 512,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomSpacer(verticalSpace: 45),
                    // Title
                    Text(
                      "Connect to Metamask.",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Constants.paletteSelected["medium"]),
                      textAlign: TextAlign.center,
                    ),
                    // Card
                    const CustomSpacer(verticalSpace: 22),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Constants.paletteSelected["shadow"]!
                                  .withOpacity(0.55),
                              blurRadius: 40)
                        ]),
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 10, 16, 16),
                            child: Column(
                              children: [
                                Image.asset(
                                  UtilitiesFunctions.parseFilePath(
                                      Constants.metamaskIconPath),
                                  height: 90,
                                  fit: BoxFit.scaleDown,
                                ),
                                const CustomSpacer(verticalSpace: 16),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text("Metamask",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Constants
                                              .paletteSelected["medium"])),
                                ),
                                const CustomSpacer(verticalSpace: 26),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomElevatedButton(
                                        text: "Connect",
                                        onPressed: () => context
                                            .read<MetaMaskProvider>()
                                            .connect(_),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Actions
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              text: "Cancel",
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  // bool _loggedIn = false;
  // bool _loading = false;

  // bool isLoggedIn() => _loggedIn;
  // bool isLoading() => _loading;

  // LoginState() {
  //   if (_auth.currentUser != null) {
  //     _loggedIn = true;
  //     notifyListeners();
  //   }
  // }

  // void login() async {
  //   _loading = true;
  //   notifyListeners();

  //   var user = await signInWithGoogle();

  //   _loading = false;
  //   if (user != null && _auth.currentUser.uid == user.uid) {
  //     _loggedIn = true;
  //   } else {
  //     _loggedIn = false;
  //   }

  //   notifyListeners();
  // }

  // void logout() async {
  //   await signOutGoogle();
  //   await _auth.signOut();
  //   _loggedIn = false;
  //   notifyListeners();
  // }

  // Future<User> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );

  //   final UserCredential authResult =
  //       await _auth.signInWithCredential(credential);
  //   final User user = authResult.user;

  //   return user;
  // }

  // Future<void> signOutGoogle() async {
  //   await googleSignIn.signOut();
  // }

  // User getCurrentUser() {
  //   return _auth.currentUser;
  // }
}
