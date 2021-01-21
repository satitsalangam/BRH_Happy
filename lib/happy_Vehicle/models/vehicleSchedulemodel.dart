class VehicleSchedulemodel {
  String vsdId;
  String vsdActive;
  String vvLocationid;
  String vvEmpid;
  String vsdCreateby;
  String vsdCreatedate;
  String vsdEditby;
  String vsdEditdate;
  String vsdSundayStart;
  String vsdSundayFinish;
  String vsdMondayStart;
  String vsdMondayFinish;
  String vsdTuesdayStart;
  String vsdTuesdayFinish;
  String vsdWednesdayStart;
  String vsdWednesdayFinish;
  String vsdThursdayStart;
  String vsdThursdayFinish;
  String vsdFridayStart;
  String vsdFridayFinish;
  String vsdSaturdayStart;
  String vsdSaturdayFinish;
  String vsdStatus;

  VehicleSchedulemodel(
      {this.vsdId,
      this.vsdActive,
      this.vvLocationid,
      this.vvEmpid,
      this.vsdCreateby,
      this.vsdCreatedate,
      this.vsdEditby,
      this.vsdEditdate,
      this.vsdSundayStart,
      this.vsdSundayFinish,
      this.vsdMondayStart,
      this.vsdMondayFinish,
      this.vsdTuesdayStart,
      this.vsdTuesdayFinish,
      this.vsdWednesdayStart,
      this.vsdWednesdayFinish,
      this.vsdThursdayStart,
      this.vsdThursdayFinish,
      this.vsdFridayStart,
      this.vsdFridayFinish,
      this.vsdSaturdayStart,
      this.vsdSaturdayFinish,
      this.vsdStatus});

  VehicleSchedulemodel.fromJson(Map<String, dynamic> json) {
    vsdId = json['vsd_id'];
    vsdActive = json['vsd_active'];
    vvLocationid = json['vv_locationid'];
    vvEmpid = json['vv_empid'];
    vsdCreateby = json['vsd_createby'];
    vsdCreatedate = json['vsd_createdate'];
    vsdEditby = json['vsd_editby'];
    vsdEditdate = json['vsd_editdate'];
    vsdSundayStart = json['vsd_sunday_start'];
    vsdSundayFinish = json['vsd_sunday_finish'];
    vsdMondayStart = json['vsd_monday_start'];
    vsdMondayFinish = json['vsd_monday_finish'];
    vsdTuesdayStart = json['vsd_tuesday_start'];
    vsdTuesdayFinish = json['vsd_tuesday_finish'];
    vsdWednesdayStart = json['vsd_wednesday_start'];
    vsdWednesdayFinish = json['vsd_wednesday_finish'];
    vsdThursdayStart = json['vsd_thursday_start'];
    vsdThursdayFinish = json['vsd_thursday_finish'];
    vsdFridayStart = json['vsd_friday_start'];
    vsdFridayFinish = json['vsd_friday_finish'];
    vsdSaturdayStart = json['vsd_saturday_start'];
    vsdSaturdayFinish = json['vsd_saturday_finish'];
    vsdStatus = json['vsd_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vsd_id'] = this.vsdId;
    data['vsd_active'] = this.vsdActive;
    data['vv_locationid'] = this.vvLocationid;
    data['vv_empid'] = this.vvEmpid;
    data['vsd_createby'] = this.vsdCreateby;
    data['vsd_createdate'] = this.vsdCreatedate;
    data['vsd_editby'] = this.vsdEditby;
    data['vsd_editdate'] = this.vsdEditdate;
    data['vsd_sunday_start'] = this.vsdSundayStart;
    data['vsd_sunday_finish'] = this.vsdSundayFinish;
    data['vsd_monday_start'] = this.vsdMondayStart;
    data['vsd_monday_finish'] = this.vsdMondayFinish;
    data['vsd_tuesday_start'] = this.vsdTuesdayStart;
    data['vsd_tuesday_finish'] = this.vsdTuesdayFinish;
    data['vsd_wednesday_start'] = this.vsdWednesdayStart;
    data['vsd_wednesday_finish'] = this.vsdWednesdayFinish;
    data['vsd_thursday_start'] = this.vsdThursdayStart;
    data['vsd_thursday_finish'] = this.vsdThursdayFinish;
    data['vsd_friday_start'] = this.vsdFridayStart;
    data['vsd_friday_finish'] = this.vsdFridayFinish;
    data['vsd_saturday_start'] = this.vsdSaturdayStart;
    data['vsd_saturday_finish'] = this.vsdSaturdayFinish;
    data['vsd_status'] = this.vsdStatus;
    return data;
  }
}

