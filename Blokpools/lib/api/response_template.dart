import 'dart:convert';

class ResponseTemplate {
  final bool correct;
  final Map<String, dynamic> data;
  final String err;

  ResponseTemplate(this.correct, this.data, this.err);

  factory ResponseTemplate.fromJson(Map<String, dynamic> json) {
    return ResponseTemplate(
        json["correct"],
        json["data"] != ""
            ? json["data"] as Map<String, dynamic>
            : <String, dynamic>{},
        json["err"]);
  }
}
