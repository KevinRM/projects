import 'dart:async';
import 'package:encrypt/encrypt.dart' as encr;
import 'package:evogalaxy/api/api_communication.dart';
import 'package:evogalaxy/api/models/user.model.dart';
import 'package:evogalaxy/api/request_template.dart';
import 'package:evogalaxy/api/response_template.dart';
import 'package:evogalaxy/api/routes.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserState with ChangeNotifier {
  BuildContext? _context;
  LanguageState? _languageState;
  bool isLogged = false;
  UserModel userModel = UserModel();
  String atoken = "";
  DateTime dateAtokenExpire = DateTime.now();
  Timer? _timerCheckSession;

  UserState() {
    initialize();
  }

  @override
  void dispose() {
    _timerCheckSession?.cancel();
    super.dispose();
  }

  void setContext(BuildContext contx, LanguageState lgState) {
    _context = contx;
    _languageState = lgState;
  }

  void initialize() async {
    await loadAccTok();
    await checkHasSession();
    if (isLogged && userModel.username == null) {
      getUserData();
    }
    _timerCheckSession =
        Timer.periodic(Constants.checkSessionDuration, (timer) {
      checkHasSession();
    });
  }

  Future<void> loadAccTok() async {
    final sharPref = await SharedPreferences.getInstance();
    String uid = sharPref.getString("uId") ?? "";
    String uiv = sharPref.getString("uIv") ?? "";
    String at = sharPref.getString("at") ?? "";
    String atDa = sharPref.getString("atDa") ?? "";

    if (uid.isNotEmpty && uiv.isNotEmpty && at.isNotEmpty && atDa.isNotEmpty) {
      final encrypter = encr.Encrypter(encr.AES(encr.Key.fromUtf8(uid)));
      final iv = encr.IV.fromBase64(uiv);
      at = encrypter.decrypt(encr.Encrypted.fromBase64(at), iv: iv);
      atDa = encrypter.decrypt(encr.Encrypted.fromBase64(atDa), iv: iv);
      atoken = at;
      dateAtokenExpire = DateTime.parse(atDa);
    }
  }

  Future<void> saveAccToken(String uId, Map<String, dynamic> data) async {
    atoken = data['tk'];
    dateAtokenExpire = DateTime.fromMillisecondsSinceEpoch(data['exp']);

    final encrypter = encr.Encrypter(encr.AES(encr.Key.fromUtf8(uId)));
    final iv = encr.IV.fromLength(16);
    encr.Encrypted at = encrypter.encrypt(atoken, iv: iv);
    encr.Encrypted atDa =
        encrypter.encrypt(dateAtokenExpire.toString(), iv: iv);

    final sharPref = await SharedPreferences.getInstance();

    await sharPref.setString("uId", uId);
    await sharPref.setString("uIv", iv.base64);
    await sharPref.setString("at", at.base64);
    await sharPref.setString("atDa", atDa.base64);
  }

  Future<String> loginUser(String username, String pass) async {
    try {
      RequestTemplate request =
          RequestTemplate(data: {"username": username, "pass": pass});

      ResponseTemplate result =
          await API.post(null, null, APIRoutes.signInUser, request);

      if (result.correct) {
        await saveAccToken(result.data['userId'],
            result.data["accessToken"]); // Save aT to permanent session
        await checkHasSession();
        await getUserData();
        return "";
      } else {
        return result.err;
      }
    } catch (e) {
      return "errorComServer";
    }
  }

  Future<void> deleteAccToken() async {
    final sharPref = await SharedPreferences.getInstance();
    sharPref.remove("uId");
    sharPref.remove("uIv");
    sharPref.remove("at");
    sharPref.remove("atDa");
  }

  Future<void> checkHasSession() async {
    if (atoken != "" && dateAtokenExpire.isAfter(DateTime.now())) {
      changeLoginState(true);
    } else if (isLogged) {
      signOut();
      if (_context != null && _languageState != null) {
        UtilitiesFunctions.showSnackbar(
            _context!, _languageState!.getText(TextKeys.sessionExpired));
      }
    }
  }

  void changeLoginState(bool newState) {
    if (isLogged != newState) {
      isLogged = newState;
      notifyListeners();
    }
  }

  Future<void> getUserData() async {
    try {
      RequestTemplate request = RequestTemplate();
      ResponseTemplate result = await API
          .post(null, null, APIRoutes.getUserData, request, idToken: atoken);

      if (result.correct) {
        userModel = UserModel.fromJson(result.data);
      } else {
        UtilitiesFunctions.showSnackbar(
            _context!, _languageState!.pareseErrorTxt(result.err));
        signOut();
      }
    } catch (e) {
      UtilitiesFunctions.showSnackbar(
          _context!, _languageState!.getText(TextKeys.defaultError));
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    deleteAccToken();
    changeLoginState(false);
  }

  // TODO: Verificar email

  /*
  User? user = FirebaseAuth.instance.currentUser;
if (user!= null && !user.emailVerified) {
  await user.sendEmailVerification();
}
*/
}
