class CountOutToDay {
  String countOutToDay;

  CountOutToDay({this.countOutToDay});

  CountOutToDay.fromJson(Map<String, dynamic> json) {
    countOutToDay = json['countOutToDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countOutToDay'] = this.countOutToDay;
    return data;
  }
}
