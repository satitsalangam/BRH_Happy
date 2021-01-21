class RattingCheckIn {
  String ratting;

  RattingCheckIn({this.ratting});

  RattingCheckIn.fromJson(Map<String, dynamic> json) {
    ratting = json['ratting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratting'] = this.ratting;
    return data;
  }
}

