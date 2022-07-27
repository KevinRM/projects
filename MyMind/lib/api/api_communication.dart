import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_mind/states/language_state.dart';

import '../constants.dart';
import 'request_template.dart';
import 'response_template.dart';

class API {
  static Future<ResponseTemplate> post(
      String path, RequestTemplate requestTemplate,
      {String idToken = ""}) async {
    try {
      var url = Uri.parse(Constants.apiURL + path);
      var response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: 'Bearer ' + idToken,
            "languageselected": LanguageState.languageSelected.index.toString()
          },
          body: jsonEncode(requestTemplate));

      if (response.statusCode == 200) {
        ResponseTemplate responseTemplate =
            ResponseTemplate.fromJson(jsonDecode(response.body));
        return responseTemplate;
      } else {
        return ResponseTemplate(false, {}, "errorComServer");
      }
    } catch (e) {
      return ResponseTemplate(false, {}, "errorComServer");
    }
  }
}
