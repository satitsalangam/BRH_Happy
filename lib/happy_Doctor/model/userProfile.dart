class UserProfileDoctor {
  String drForename;
  String drSurname;
  String drEnglishname;
  String drImg;
  String drDoctorid;
  String dlName;
  String dsId;
  String dsActive;
  String dsDlid;
  String dsDrid;
  String dsCreateby;
  String dsCreatedate;
  String dsEditby;
  String dsEditdate;
  String dsSundayStart;
  String dsSundayFinish;
  String dsMondayStart;
  String dsMondayFinish;
  String dsTuesdayStart;
  String dsTuesdayFinish;
  String dsWednesdayStart;
  String dsWednesdayFinish;
  String dsThursdayStart;
  String dsThursdayFinish;
  String dsFridayStart;
  String dsFridayFinish;
  String dsSaturdayStart;
  String dsSaturdayFinish;
  String dsStatus;

  UserProfileDoctor(
      {this.drForename,
      this.drSurname,
      this.drEnglishname,
      this.drImg,
      this.drDoctorid,
      this.dlName,
      this.dsId,
      this.dsActive,
      this.dsDlid,
      this.dsDrid,
      this.dsCreateby,
      this.dsCreatedate,
      this.dsEditby,
      this.dsEditdate,
      this.dsSundayStart,
      this.dsSundayFinish,
      this.dsMondayStart,
      this.dsMondayFinish,
      this.dsTuesdayStart,
      this.dsTuesdayFinish,
      this.dsWednesdayStart,
      this.dsWednesdayFinish,
      this.dsThursdayStart,
      this.dsThursdayFinish,
      this.dsFridayStart,
      this.dsFridayFinish,
      this.dsSaturdayStart,
      this.dsSaturdayFinish,
      this.dsStatus});

  UserProfileDoctor.fromJson(Map<String, dynamic> json) {
    drForename = json['dr_forename'];
    drSurname = json['dr_surname'];
    drEnglishname = json['dr_englishname'];
    drImg = json['dr_img'];
    drDoctorid = json['dr_doctorid'];
    dlName = json['dl_name'];
    dsId = json['ds_id'];
    dsActive = json['ds_active'];
    dsDlid = json['ds_dlid'];
    dsDrid = json['ds_drid'];
    dsCreateby = json['ds_createby'];
    dsCreatedate = json['ds_createdate'];
    dsEditby = json['ds_editby'];
    dsEditdate = json['ds_editdate'];
    dsSundayStart = json['ds_sunday_start'];
    dsSundayFinish = json['ds_sunday_finish'];
    dsMondayStart = json['ds_monday_start'];
    dsMondayFinish = json['ds_monday_finish'];
    dsTuesdayStart = json['ds_tuesday_start'];
    dsTuesdayFinish = json['ds_tuesday_finish'];
    dsWednesdayStart = json['ds_wednesday_start'];
    dsWednesdayFinish = json['ds_wednesday_finish'];
    dsThursdayStart = json['ds_thursday_start'];
    dsThursdayFinish = json['ds_thursday_finish'];
    dsFridayStart = json['ds_friday_start'];
    dsFridayFinish = json['ds_friday_finish'];
    dsSaturdayStart = json['ds_saturday_start'];
    dsSaturdayFinish = json['ds_saturday_finish'];
    dsStatus = json['ds_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dr_forename'] = this.drForename;
    data['dr_surname'] = this.drSurname;
    data['dr_englishname'] = this.drEnglishname;
    data['dr_img'] = this.drImg;
    data['dr_doctorid'] = this.drDoctorid;
    data['dl_name'] = this.dlName;
    data['ds_id'] = this.dsId;
    data['ds_active'] = this.dsActive;
    data['ds_dlid'] = this.dsDlid;
    data['ds_drid'] = this.dsDrid;
    data['ds_createby'] = this.dsCreateby;
    data['ds_createdate'] = this.dsCreatedate;
    data['ds_editby'] = this.dsEditby;
    data['ds_editdate'] = this.dsEditdate;
    data['ds_sunday_start'] = this.dsSundayStart;
    data['ds_sunday_finish'] = this.dsSundayFinish;
    data['ds_monday_start'] = this.dsMondayStart;
    data['ds_monday_finish'] = this.dsMondayFinish;
    data['ds_tuesday_start'] = this.dsTuesdayStart;
    data['ds_tuesday_finish'] = this.dsTuesdayFinish;
    data['ds_wednesday_start'] = this.dsWednesdayStart;
    data['ds_wednesday_finish'] = this.dsWednesdayFinish;
    data['ds_thursday_start'] = this.dsThursdayStart;
    data['ds_thursday_finish'] = this.dsThursdayFinish;
    data['ds_friday_start'] = this.dsFridayStart;
    data['ds_friday_finish'] = this.dsFridayFinish;
    data['ds_saturday_start'] = this.dsSaturdayStart;
    data['ds_saturday_finish'] = this.dsSaturdayFinish;
    data['ds_status'] = this.dsStatus;
    return data;
  }
}
