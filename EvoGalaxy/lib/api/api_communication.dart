import 'dart:convert';
import 'dart:io';
import 'package:evogalaxy/api/request_template.dart';
import 'package:evogalaxy/api/response_template.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:evogalaxy/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<ResponseTemplate> post(
      BuildContext? context,
      LanguageState? languageState,
      String path,
      RequestTemplate requestTemplate,
      {String idToken = ""}) async {
    try {
      var url = Uri.parse(Constants.apiURL + path);
      var response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: 'Bearer ' + idToken
          },
          body: jsonEncode(requestTemplate));

      // print(response.body);
      if (response.statusCode == 200) {
        ResponseTemplate responseTemplate =
            ResponseTemplate.fromJson(jsonDecode(response.body));
        if (!responseTemplate.correct &&
            context != null &&
            languageState != null) {
          UtilitiesFunctions.showAlertDialog(context, "Error",
              languageState.pareseErrorTxt(responseTemplate.err));
        }
        return responseTemplate;
      } else {
        if (context != null && languageState != null) {
          UtilitiesFunctions.showAlertDialog(
              context, "ERROR", languageState.getText(TextKeys.errorComServer));
        }
        return ResponseTemplate(false, {}, "");
      }
    } catch (e) {
      if (context != null && languageState != null) {
        UtilitiesFunctions.showAlertDialog(
            context, "ERROR", languageState.getText(TextKeys.errorComServer));
      }
      return ResponseTemplate(false, {}, "");
    }
  }
}
