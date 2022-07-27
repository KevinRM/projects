enum TYPE_ANALYTICS { pageView }

enum VALUE_TYPE_ANALYTICS { number }

class Analytics {
  String? typeAnalytics;
  dynamic value;

  Analytics({this.typeAnalytics, this.value});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeAnalytics'] = typeAnalytics;
    data['value'] = value;

    return data;
  }
}
