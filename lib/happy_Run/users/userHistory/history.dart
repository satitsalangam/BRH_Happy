import 'dart:convert';

import 'package:brhhappy/happy_Run/model/image_run.dart';
import 'package:brhhappy/happy_Run/model/userModel.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/showBenner.dart';

import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'listHistory.dart';

class UserHistory extends StatefulWidget {
  @override
  _UserHistoryState createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  List<ImageRun> imageRuns = List();
  bool loadStatus = true;
  bool loadUsers = true;
  Usermodel usermodel;
  String fullname, image, deparment, pName, empcode;
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        "${MyConstantRun().domain}getProfile.php?select=true&empid=$empid";
    await Dio().get(url).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            usermodel = Usermodel.fromJson(map);
            empcode = usermodel.empId;
            fullname = usermodel.empPnamefullTh;
            image = usermodel.empImg;
            deparment = usermodel.empDeptdesc;
            pName = usermodel.empPnameTh;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ShowBenner(size: size),
          loadUsers ? MyStyle().showProgress() : showTitle(size),
          ListHistory(),
        ],
      ),
    );
  }

  Widget showTitle(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            child: CircleAvatar(
                radius: 33,
                backgroundImage: usermodel.empImg != null
                    ? NetworkImage(
                        "${MyConstantRun().domain}ImagesProfile/${usermodel.empImg}")
                    : usermodel.empPnameTh.toString() == 'นาย'
                        ? AssetImage('assets/images/avatarMan.png')
                        : AssetImage('assets/images/avatarWomen.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$empcode',
                  style: titleStyle,
                ),
                Text(
                  '$pName $fullname',
                  style: titleStyle,
                ),
                Container(
                  width: size.width * 0.65,
                  child: Text(
                    '$deparment',
                    style: departmentStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
