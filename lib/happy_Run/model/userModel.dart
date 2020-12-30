class Usermodel {
  String rowNumber;
  String rowRanking;
  String empId;
  String empPassword;
  String empGroup;
  String empPaygroup;
  String empPname;
  String empFname;
  String empLname;
  String empPnameTh;
  String empPnamefullTh;
  String empFnameTh;
  String empLnameTh;
  String empDeptid;
  String empDeptdesc;
  String empPosid;
  String empPosdesc;
  String empActive;
  String empImg;
  String empPoint;
  String empTotalpoint;
  String empStatus;
  String empEditdate;
  String depthod1;
  String depthod2;
  String dsHod;
  String dummy;

  Usermodel(
      {this.rowNumber,
      this.rowRanking,
      this.empId,
      this.empPassword,
      this.empGroup,
      this.empPaygroup,
      this.empPname,
      this.empFname,
      this.empLname,
      this.empPnameTh,
      this.empPnamefullTh,
      this.empFnameTh,
      this.empLnameTh,
      this.empDeptid,
      this.empDeptdesc,
      this.empPosid,
      this.empPosdesc,
      this.empActive,
      this.empImg,
      this.empPoint,
      this.empTotalpoint,
      this.empStatus,
      this.empEditdate,
      this.depthod1,
      this.depthod2,
      this.dsHod,
      this.dummy});

  Usermodel.fromJson(Map<String, dynamic> json) {
    rowNumber = json['row_number'];
    rowRanking = json['row_ranking'];
    empId = json['emp_id'];
    empPassword = json['emp_password'];
    empGroup = json['emp_group'];
    empPaygroup = json['emp_paygroup'];
    empPname = json['emp_pname'];
    empFname = json['emp_fname'];
    empLname = json['emp_lname'];
    empPnameTh = json['emp_pname_th'];
    empPnamefullTh = json['emp_pnamefull_th'];
    empFnameTh = json['emp_fname_th'];
    empLnameTh = json['emp_lname_th'];
    empDeptid = json['emp_deptid'];
    empDeptdesc = json['emp_deptdesc'];
    empPosid = json['emp_posid'];
    empPosdesc = json['emp_posdesc'];
    empActive = json['emp_active'];
    empImg = json['emp_img'];
    empPoint = json['emp_point'];
    empTotalpoint = json['emp_totalpoint'];
    empStatus = json['emp_status'];
    empEditdate = json['emp_editdate'];
    depthod1 = json['depthod1'];
    depthod2 = json['depthod2'];
    dsHod = json['ds_hod'];
    dummy = json['dummy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_number'] = this.rowNumber;
    data['row_ranking'] = this.rowRanking;
    data['emp_id'] = this.empId;
    data['emp_password'] = this.empPassword;
    data['emp_group'] = this.empGroup;
    data['emp_paygroup'] = this.empPaygroup;
    data['emp_pname'] = this.empPname;
    data['emp_fname'] = this.empFname;
    data['emp_lname'] = this.empLname;
    data['emp_pname_th'] = this.empPnameTh;
    data['emp_pnamefull_th'] = this.empPnamefullTh;
    data['emp_fname_th'] = this.empFnameTh;
    data['emp_lname_th'] = this.empLnameTh;
    data['emp_deptid'] = this.empDeptid;
    data['emp_deptdesc'] = this.empDeptdesc;
    data['emp_posid'] = this.empPosid;
    data['emp_posdesc'] = this.empPosdesc;
    data['emp_active'] = this.empActive;
    data['emp_img'] = this.empImg;
    data['emp_point'] = this.empPoint;
    data['emp_totalpoint'] = this.empTotalpoint;
    data['emp_status'] = this.empStatus;
    data['emp_editdate'] = this.empEditdate;
    data['depthod1'] = this.depthod1;
    data['depthod2'] = this.depthod2;
    data['ds_hod'] = this.dsHod;
    data['dummy'] = this.dummy;
    return data;
  }
}
