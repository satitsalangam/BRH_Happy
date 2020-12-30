class LoactionDoctor {
  String dlId;
  String dlName;

  LoactionDoctor({this.dlId, this.dlName});

  LoactionDoctor.fromJson(Map<String, dynamic> json) {
    dlId = json['dl_id'];
    dlName = json['dl_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dl_id'] = this.dlId;
    data['dl_name'] = this.dlName;
    return data;
  }
}
