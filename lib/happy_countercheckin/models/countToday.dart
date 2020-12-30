class CountToDay {
  String countToDay;

  CountToDay({this.countToDay});

  CountToDay.fromJson(Map<String, dynamic> json) {
    countToDay = json['countToDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countToDay'] = this.countToDay;
    return data;
  }
}
