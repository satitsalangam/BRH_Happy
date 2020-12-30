class MoreEvaluate {
  String countMoreEvaluate;

  MoreEvaluate({this.countMoreEvaluate});

  MoreEvaluate.fromJson(Map<String, dynamic> json) {
    countMoreEvaluate = json['countMoreEvaluate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countMoreEvaluate'] = this.countMoreEvaluate;
    return data;
  }
}
