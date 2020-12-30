class UserRatting {
  String dsId;
  String dsDlid;
  String dlName;
  String dsDrid;
  String drDoctorid;
  String drForename;
  String drSurname;
  String drEnglishname;
  String drRating;
  String startDate;
  String finishDate;
  String dsStatus;
  String dsActive;
  String drImg;

  UserRatting(
      {this.dsId,
      this.dsDlid,
      this.dlName,
      this.dsDrid,
      this.drDoctorid,
      this.drForename,
      this.drSurname,
      this.drEnglishname,
      this.drRating,
      this.startDate,
      this.finishDate,
      this.dsStatus,
      this.dsActive,
      this.drImg});

  UserRatting.fromJson(Map<String, dynamic> json) {
    dsId = json['ds_id'];
    dsDlid = json['ds_dlid'];
    dlName = json['dl_name'];
    dsDrid = json['ds_drid'];
    drDoctorid = json['dr_doctorid'];
    drForename = json['dr_forename'];
    drSurname = json['dr_surname'];
    drEnglishname = json['dr_englishname'];
    drRating = json['dr_rating'];
    startDate = json['StartDate'];
    finishDate = json['FinishDate'];
    dsStatus = json['ds_status'];
    dsActive = json['ds_active'];
    drImg = json['dr_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ds_id'] = this.dsId;
    data['ds_dlid'] = this.dsDlid;
    data['dl_name'] = this.dlName;
    data['ds_drid'] = this.dsDrid;
    data['dr_doctorid'] = this.drDoctorid;
    data['dr_forename'] = this.drForename;
    data['dr_surname'] = this.drSurname;
    data['dr_englishname'] = this.drEnglishname;
    data['dr_rating'] = this.drRating;
    data['StartDate'] = this.startDate;
    data['FinishDate'] = this.finishDate;
    data['ds_status'] = this.dsStatus;
    data['ds_active'] = this.dsActive;
    data['dr_img'] = this.drImg;
    return data;
  }
}
