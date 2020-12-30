class CountEvaluate {
  String countEvaluate;

  CountEvaluate({this.countEvaluate});

  CountEvaluate.fromJson(Map<String, dynamic> json) {
    countEvaluate = json['countEvaluate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countEvaluate'] = this.countEvaluate;
    return data;
  }
}
