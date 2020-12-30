class ImageRun {
  String imId;
  String imEmpid;
  String imStatus;
  String imCreatetimer;
  String imDistance;
  String imTimer;
  String imPname;
  String imFname;
  String imLname;
  String imCommend;
  String imImage;
  String imDate;
  String empPnameTh;
  String empPnamefullTh;
  String empDeptdesc;

  ImageRun(
      {this.imId,
      this.imEmpid,
      this.imStatus,
      this.imCreatetimer,
      this.imDistance,
      this.imTimer,
      this.imPname,
      this.imFname,
      this.imLname,
      this.imCommend,
      this.imImage,
      this.imDate,
      this.empPnameTh,
      this.empPnamefullTh,
      this.empDeptdesc});

  ImageRun.fromJson(Map<String, dynamic> json) {
    imId = json['im_id'];
    imEmpid = json['im_empid'];
    imStatus = json['im_status'];
    imCreatetimer = json['im_createtimer'];
    imDistance = json['im_distance'];
    imTimer = json['im_timer'];
    imPname = json['im_pname'];
    imFname = json['im_fname'];
    imLname = json['im_lname'];
    imCommend = json['im_commend'];
    imImage = json['im_image'];
    imDate = json['im_date'];
    empPnameTh = json['emp_pname_th'];
    empPnamefullTh = json['emp_pnamefull_th'];
    empDeptdesc = json['emp_deptdesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['im_id'] = this.imId;
    data['im_empid'] = this.imEmpid;
    data['im_status'] = this.imStatus;
    data['im_createtimer'] = this.imCreatetimer;
    data['im_distance'] = this.imDistance;
    data['im_timer'] = this.imTimer;
    data['im_pname'] = this.imPname;
    data['im_fname'] = this.imFname;
    data['im_lname'] = this.imLname;
    data['im_commend'] = this.imCommend;
    data['im_image'] = this.imImage;
    data['im_date'] = this.imDate;
    data['emp_pname_th'] = this.empPnameTh;
    data['emp_pnamefull_th'] = this.empPnamefullTh;
    data['emp_deptdesc'] = this.empDeptdesc;
    return data;
  }
}
