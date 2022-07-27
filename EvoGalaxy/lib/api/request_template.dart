class RequestTemplate {
  final Map<String, dynamic>? data;

  RequestTemplate({this.data});

  Map<String, dynamic> toJson() => {'data': data};
}
