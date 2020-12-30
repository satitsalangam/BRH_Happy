class CounterCheackin {
  String ccId;
  String ccDatein;
  String ccTimein;
  String ccDateout;
  String ccTimeout;
  String ccEmpid;
  String ccDeptid;
  String ccStatus;
  String ccType;
  String ccEvaluate;
  String ccSuggestion;
  String ccLatCheackin;
  String ccLngCheackin;
  String ccLatCheackout;
  String ccLngCheackout;
  String ccRadiuslat;
  String ccRadiuslng;
  String ccLoactionname;
  String dsDesc;

  CounterCheackin(
      {this.ccId,
      this.ccDatein,
      this.ccTimein,
      this.ccDateout,
      this.ccTimeout,
      this.ccEmpid,
      this.ccDeptid,
      this.ccStatus,
      this.ccType,
      this.ccEvaluate,
      this.ccSuggestion,
      this.ccLatCheackin,
      this.ccLngCheackin,
      this.ccLatCheackout,
      this.ccLngCheackout,
      this.ccRadiuslat,
      this.ccRadiuslng,
      this.ccLoactionname,
      this.dsDesc});

  CounterCheackin.fromJson(Map<String, dynamic> json) {
    ccId = json['cc_id'];
    ccDatein = json['cc_datein'];
    ccTimein = json['cc_timein'];
    ccDateout = json['cc_dateout'];
    ccTimeout = json['cc_timeout'];
    ccEmpid = json['cc_empid'];
    ccDeptid = json['cc_deptid'];
    ccStatus = json['cc_status'];
    ccType = json['cc_type'];
    ccEvaluate = json['cc_evaluate'];
    ccSuggestion = json['cc_suggestion'];
    ccLatCheackin = json['cc_latCheackin'];
    ccLngCheackin = json['cc_lngCheackin'];
    ccLatCheackout = json['cc_latCheackout'];
    ccLngCheackout = json['cc_lngCheackout'];
    ccRadiuslat = json['cc_radiuslat'];
    ccRadiuslng = json['cc_radiuslng'];
    ccLoactionname = json['cc_loactionname'];
    dsDesc = json['ds_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cc_id'] = this.ccId;
    data['cc_datein'] = this.ccDatein;
    data['cc_timein'] = this.ccTimein;
    data['cc_dateout'] = this.ccDateout;
    data['cc_timeout'] = this.ccTimeout;
    data['cc_empid'] = this.ccEmpid;
    data['cc_deptid'] = this.ccDeptid;
    data['cc_status'] = this.ccStatus;
    data['cc_type'] = this.ccType;
    data['cc_evaluate'] = this.ccEvaluate;
    data['cc_suggestion'] = this.ccSuggestion;
    data['cc_latCheackin'] = this.ccLatCheackin;
    data['cc_lngCheackin'] = this.ccLngCheackin;
    data['cc_latCheackout'] = this.ccLatCheackout;
    data['cc_lngCheackout'] = this.ccLngCheackout;
    data['cc_radiuslat'] = this.ccRadiuslat;
    data['cc_radiuslng'] = this.ccRadiuslng;
    data['cc_loactionname'] = this.ccLoactionname;
    data['ds_desc'] = this.dsDesc;
    return data;
  }
}
