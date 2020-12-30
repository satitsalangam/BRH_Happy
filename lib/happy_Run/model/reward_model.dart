class RewardModel {
  String reId;
  String reTitle;
  String reDatails;
  String reImge;
  String reCreatedate;
  String reEditdate;
  String score;
  String reCount;

  RewardModel(
      {this.reId,
      this.reTitle,
      this.reDatails,
      this.reImge,
      this.reCreatedate,
      this.reEditdate,
      this.score,
      this.reCount});

  RewardModel.fromJson(Map<String, dynamic> json) {
    reId = json['re_id'];
    reTitle = json['re_title'];
    reDatails = json['re_datails'];
    reImge = json['re_imge'];
    reCreatedate = json['re_createdate'];
    reEditdate = json['re_editdate'];
    score = json['score'];
    reCount = json['re_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['re_id'] = this.reId;
    data['re_title'] = this.reTitle;
    data['re_datails'] = this.reDatails;
    data['re_imge'] = this.reImge;
    data['re_createdate'] = this.reCreatedate;
    data['re_editdate'] = this.reEditdate;
    data['score'] = this.score;
    data['re_count'] = this.reCount;
    return data;
  }
}
