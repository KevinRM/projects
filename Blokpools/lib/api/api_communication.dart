import 'dart:convert';
import 'dart:io';
import 'package:blokstaking/api/request_template.dart';
import 'package:blokstaking/api/response_template.dart';
import 'package:blokstaking/constants.dart';
import 'package:blokstaking/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<ResponseTemplate> post(
      BuildContext? context, String path, RequestTemplate requestTemplate,
      {String wallet = ""}) async {
    try {
      var url = Uri.parse(Constants.apiURL + path);
      var response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: 'Bearer ' + wallet
          },
          body: jsonEncode(requestTemplate));

      // print(response.body);
      if (response.statusCode == 200) {
        ResponseTemplate responseTemplate =
            ResponseTemplate.fromJson(jsonDecode(response.body));
        if (!responseTemplate.correct && context != null) {
          UtilitiesFunctions.showAlertDialog(
              context, "Error", responseTemplate.err);
        }
        return responseTemplate;
      } else {
        if (context != null) {
          UtilitiesFunctions.showAlertDialog(
              context, "ERROR", "Error in communication with the blockchain");
        }
        return ResponseTemplate(false, {}, "");
      }
    } catch (e) {
      if (context != null) {
        UtilitiesFunctions.showAlertDialog(
            context, "ERROR", "Error in communication with the blockchain");
      }
      return ResponseTemplate(false, {}, "");
    }
  }
}
