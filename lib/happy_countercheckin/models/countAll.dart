class CountAll {
  String countAll;

  CountAll({this.countAll});

  CountAll.fromJson(Map<String, dynamic> json) {
    countAll = json['countAll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countAll'] = this.countAll;
    return data;
  }
}
