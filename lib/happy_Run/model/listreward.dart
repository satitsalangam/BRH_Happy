class ListReward {
  String redId;
  String reId;
  String redEmpid;
  String redCreatedate;
  String redUpdatedate;
  String redStatus;
  String redTitleReward;
  String redCountReward;
  String redScoreReward;
  String redImageReward;
  String redCommend;
  String empPnameTh;
  String empPnamefullTh;
  String empDeptdesc;
  String empImg;

  ListReward(
      {this.redId,
      this.reId,
      this.redEmpid,
      this.redCreatedate,
      this.redUpdatedate,
      this.redStatus,
      this.redTitleReward,
      this.redCountReward,
      this.redScoreReward,
      this.redImageReward,
      this.redCommend,
      this.empPnameTh,
      this.empPnamefullTh,
      this.empDeptdesc,
      this.empImg});

  ListReward.fromJson(Map<String, dynamic> json) {
    redId = json['red_id'];
    reId = json['re_id'];
    redEmpid = json['red_empid'];
    redCreatedate = json['red_createdate'];
    redUpdatedate = json['red_updatedate'];
    redStatus = json['red_status'];
    redTitleReward = json['red_title_reward'];
    redCountReward = json['red_count_reward'];
    redScoreReward = json['red_score_reward'];
    redImageReward = json['red_imageReward'];
    redCommend = json['red_commend'];
    empPnameTh = json['emp_pname_th'];
    empPnamefullTh = json['emp_pnamefull_th'];
    empDeptdesc = json['emp_deptdesc'];
    empImg = json['emp_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['red_id'] = this.redId;
    data['re_id'] = this.reId;
    data['red_empid'] = this.redEmpid;
    data['red_createdate'] = this.redCreatedate;
    data['red_updatedate'] = this.redUpdatedate;
    data['red_status'] = this.redStatus;
    data['red_title_reward'] = this.redTitleReward;
    data['red_count_reward'] = this.redCountReward;
    data['red_score_reward'] = this.redScoreReward;
    data['red_imageReward'] = this.redImageReward;
    data['red_commend'] = this.redCommend;
    data['emp_pname_th'] = this.empPnameTh;
    data['emp_pnamefull_th'] = this.empPnamefullTh;
    data['emp_deptdesc'] = this.empDeptdesc;
    data['emp_img'] = this.empImg;
    return data;
  }
}
