class RunPopular {
  String imEmpid;
  String distance;
  String empPnameTh;
  String empPnamefullTh;
  String empDeptdesc;
  String empImg;

  RunPopular(
      {this.imEmpid,
      this.distance,
      this.empPnameTh,
      this.empPnamefullTh,
      this.empDeptdesc,
      this.empImg});

  RunPopular.fromJson(Map<String, dynamic> json) {
    imEmpid = json['im_empid'];
    distance = json['distance'];
    empPnameTh = json['emp_pname_th'];
    empPnamefullTh = json['emp_pnamefull_th'];
    empDeptdesc = json['emp_deptdesc'];
    empImg = json['emp_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['im_empid'] = this.imEmpid;
    data['distance'] = this.distance;
    data['emp_pname_th'] = this.empPnameTh;
    data['emp_pnamefull_th'] = this.empPnamefullTh;
    data['emp_deptdesc'] = this.empDeptdesc;
    data['emp_img'] = this.empImg;
    return data;
  }
}
