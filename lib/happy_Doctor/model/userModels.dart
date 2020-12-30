class UserDoctor {
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

  UserDoctor(
      {this.drId,
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

  UserDoctor.fromJson(Map<String, dynamic> json) {
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
