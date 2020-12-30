class Slip {
  String moId;
  String moEmpid;
  String moPrename;
  String moFristname;
  String moLastname;
  String moDate;
  String moCraetedate;
  String moUpdatedate;
  String moSlipnumber;
  String moMoney;
  String moImageSlip;
  String moMoneyActive;
  String moCommend;
  String empPnameTh;
  String empPnamefullTh;
  String empDeptdesc;

  Slip(
      {this.moId,
      this.moEmpid,
      this.moPrename,
      this.moFristname,
      this.moLastname,
      this.moDate,
      this.moCraetedate,
      this.moUpdatedate,
      this.moSlipnumber,
      this.moMoney,
      this.moImageSlip,
      this.moMoneyActive,
      this.moCommend,
      this.empPnameTh,
      this.empPnamefullTh,
      this.empDeptdesc});

  Slip.fromJson(Map<String, dynamic> json) {
    moId = json['mo_id'];
    moEmpid = json['mo_empid'];
    moPrename = json['mo_prename'];
    moFristname = json['mo_fristname'];
    moLastname = json['mo_lastname'];
    moDate = json['mo_date'];
    moCraetedate = json['mo_craetedate'];
    moUpdatedate = json['mo_updatedate'];
    moSlipnumber = json['mo_slipnumber'];
    moMoney = json['mo_money'];
    moImageSlip = json['mo_imageSlip'];
    moMoneyActive = json['mo_money_active'];
    moCommend = json['mo_commend'];
    empPnameTh = json['emp_pname_th'];
    empPnamefullTh = json['emp_pnamefull_th'];
    empDeptdesc = json['emp_deptdesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mo_id'] = this.moId;
    data['mo_empid'] = this.moEmpid;
    data['mo_prename'] = this.moPrename;
    data['mo_fristname'] = this.moFristname;
    data['mo_lastname'] = this.moLastname;
    data['mo_date'] = this.moDate;
    data['mo_craetedate'] = this.moCraetedate;
    data['mo_updatedate'] = this.moUpdatedate;
    data['mo_slipnumber'] = this.moSlipnumber;
    data['mo_money'] = this.moMoney;
    data['mo_imageSlip'] = this.moImageSlip;
    data['mo_money_active'] = this.moMoneyActive;
    data['mo_commend'] = this.moCommend;
    data['emp_pname_th'] = this.empPnameTh;
    data['emp_pnamefull_th'] = this.empPnamefullTh;
    data['emp_deptdesc'] = this.empDeptdesc;
    return data;
  }
}
