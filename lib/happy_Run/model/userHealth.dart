class UserHealth {
  String heId;
  String heEmpid;
  String heBmi;
  String heFix;
  String heCratedate;
  String empPnameTh;
  String empPnamefullTh;
  String empImg;

  UserHealth(
      {this.heId,
      this.heEmpid,
      this.heBmi,
      this.heFix,
      this.heCratedate,
      this.empPnameTh,
      this.empPnamefullTh,
      this.empImg});

  UserHealth.fromJson(Map<String, dynamic> json) {
    heId = json['he_id'];
    heEmpid = json['he_empid'];
    heBmi = json['he_bmi'];
    heFix = json['he_fix'];
    heCratedate = json['he_cratedate'];
    empPnameTh = json['emp_pname_th'];
    empPnamefullTh = json['emp_pnamefull_th'];
    empImg = json['emp_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['he_id'] = this.heId;
    data['he_empid'] = this.heEmpid;
    data['he_bmi'] = this.heBmi;
    data['he_fix'] = this.heFix;
    data['he_cratedate'] = this.heCratedate;
    data['emp_pname_th'] = this.empPnameTh;
    data['emp_pnamefull_th'] = this.empPnamefullTh;
    data['emp_img'] = this.empImg;
    return data;
  }
}
