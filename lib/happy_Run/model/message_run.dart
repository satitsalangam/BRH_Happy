class Messagerun {
  String runMeid;
  String runMetitle;
  String runMedatails;
  String runMeimage;
  String runMecreatedate;
  String runMeupdatedate;
  String runType;
  String runMeurl;
  String runMeactive;

  Messagerun(
      {this.runMeid,
      this.runMetitle,
      this.runMedatails,
      this.runMeimage,
      this.runMecreatedate,
      this.runMeupdatedate,
      this.runType,
      this.runMeurl,
      this.runMeactive});

  Messagerun.fromJson(Map<String, dynamic> json) {
    runMeid = json['run_meid'];
    runMetitle = json['run_metitle'];
    runMedatails = json['run_medatails'];
    runMeimage = json['run_meimage'];
    runMecreatedate = json['run_mecreatedate'];
    runMeupdatedate = json['run_meupdatedate'];
    runType = json['run_type'];
    runMeurl = json['run_meurl'];
    runMeactive = json['run_meactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['run_meid'] = this.runMeid;
    data['run_metitle'] = this.runMetitle;
    data['run_medatails'] = this.runMedatails;
    data['run_meimage'] = this.runMeimage;
    data['run_mecreatedate'] = this.runMecreatedate;
    data['run_meupdatedate'] = this.runMeupdatedate;
    data['run_type'] = this.runType;
    data['run_meurl'] = this.runMeurl;
    data['run_meactive'] = this.runMeactive;
    return data;
  }
}
