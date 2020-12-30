class UserDepartment {
  String dsId;
  String dsDesc;
  String dsActive;
  String dsGroup;
  String dsEmail;

  UserDepartment(
      {this.dsId, this.dsDesc, this.dsActive, this.dsGroup, this.dsEmail});

  UserDepartment.fromJson(Map<String, dynamic> json) {
    dsId = json['ds_id'];
    dsDesc = json['ds_desc'];
    dsActive = json['ds_active'];
    dsGroup = json['ds_group'];
    dsEmail = json['ds_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ds_id'] = this.dsId;
    data['ds_desc'] = this.dsDesc;
    data['ds_active'] = this.dsActive;
    data['ds_group'] = this.dsGroup;
    data['ds_email'] = this.dsEmail;
    return data;
  }
}
