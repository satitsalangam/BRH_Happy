class HistoryDoctor {
  String drrId;
  String drrDatetime;
  String drrScore;
  String drrComment;
  String drrDlid;
  String drrDrid;
  String drrActive;
  String drId;
  String drForename;
  String drSurname;
  String drEnglishname;
  String drDoctorid;
  String drUsername;
  String drPassword;
  String drActive;
  String drCreateby;
  String drCreatedate;
  String drEditby;
  String drEditdate;
  String drImg;

  HistoryDoctor(
      {this.drrId,
      this.drrDatetime,
      this.drrScore,
      this.drrComment,
      this.drrDlid,
      this.drrDrid,
      this.drrActive,
      this.drId,
      this.drForename,
      this.drSurname,
      this.drEnglishname,
      this.drDoctorid,
      this.drUsername,
      this.drPassword,
      this.drActive,
      this.drCreateby,
      this.drCreatedate,
      this.drEditby,
      this.drEditdate,
      this.drImg});

  HistoryDoctor.fromJson(Map<String, dynamic> json) {
    drrId = json['drr_id'];
    drrDatetime = json['drr_datetime'];
    drrScore = json['drr_score'];
    drrComment = json['drr_comment'];
    drrDlid = json['drr_dlid'];
    drrDrid = json['drr_drid'];
    drrActive = json['drr_active'];
    drId = json['dr_id'];
    drForename = json['dr_forename'];
    drSurname = json['dr_surname'];
    drEnglishname = json['dr_englishname'];
    drDoctorid = json['dr_doctorid'];
    drUsername = json['dr_username'];
    drPassword = json['dr_password'];
    drActive = json['dr_active'];
    drCreateby = json['dr_createby'];
    drCreatedate = json['dr_createdate'];
    drEditby = json['dr_editby'];
    drEditdate = json['dr_editdate'];
    drImg = json['dr_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drr_id'] = this.drrId;
    data['drr_datetime'] = this.drrDatetime;
    data['drr_score'] = this.drrScore;
    data['drr_comment'] = this.drrComment;
    data['drr_dlid'] = this.drrDlid;
    data['drr_drid'] = this.drrDrid;
    data['drr_active'] = this.drrActive;
    data['dr_id'] = this.drId;
    data['dr_forename'] = this.drForename;
    data['dr_surname'] = this.drSurname;
    data['dr_englishname'] = this.drEnglishname;
    data['dr_doctorid'] = this.drDoctorid;
    data['dr_username'] = this.drUsername;
    data['dr_password'] = this.drPassword;
    data['dr_active'] = this.drActive;
    data['dr_createby'] = this.drCreateby;
    data['dr_createdate'] = this.drCreatedate;
    data['dr_editby'] = this.drEditby;
    data['dr_editdate'] = this.drEditdate;
    data['dr_img'] = this.drImg;
    return data;
  }
}
