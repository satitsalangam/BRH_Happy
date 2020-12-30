class TotalScore {
  String allscore;

  TotalScore({this.allscore});

  TotalScore.fromJson(Map<String, dynamic> json) {
    allscore = json['allscore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allscore'] = this.allscore;
    return data;
  }
}
