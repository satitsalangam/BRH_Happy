class AdminModel {
  String userId;
  String userPassword;
  String userShowname;
  String userDateadd;
  String userIdadd;
  String userStatus;
  String userActive;
  String userDateedit;
  String userIdedit;

  AdminModel(
      {this.userId,
      this.userPassword,
      this.userShowname,
      this.userDateadd,
      this.userIdadd,
      this.userStatus,
      this.userActive,
      this.userDateedit,
      this.userIdedit});

  AdminModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userPassword = json['user_password'];
    userShowname = json['user_showname'];
    userDateadd = json['user_dateadd'];
    userIdadd = json['user_idadd'];
    userStatus = json['user_status'];
    userActive = json['user_active'];
    userDateedit = json['user_dateedit'];
    userIdedit = json['user_idedit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_password'] = this.userPassword;
    data['user_showname'] = this.userShowname;
    data['user_dateadd'] = this.userDateadd;
    data['user_idadd'] = this.userIdadd;
    data['user_status'] = this.userStatus;
    data['user_active'] = this.userActive;
    data['user_dateedit'] = this.userDateedit;
    data['user_idedit'] = this.userIdedit;
    return data;
  }
}
