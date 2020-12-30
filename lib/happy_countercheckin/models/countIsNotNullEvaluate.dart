class CountIsNotNullEvaluate {
  String countNotNullEvaluate;

  CountIsNotNullEvaluate({this.countNotNullEvaluate});

  CountIsNotNullEvaluate.fromJson(Map<String, dynamic> json) {
    countNotNullEvaluate = json['countNotNullEvaluate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countNotNullEvaluate'] = this.countNotNullEvaluate;
    return data;
  }
}
