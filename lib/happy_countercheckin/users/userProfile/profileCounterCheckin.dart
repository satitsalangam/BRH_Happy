import 'dart:convert';
import 'dart:io';
import 'package:brhhappy/happy_CounterCheckin/models/employeeCode.dart';
import 'package:brhhappy/ulility/asset_image.dart';
import 'package:brhhappy/ulility/my_constants_countercheckin.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/network_image.dart';
import 'package:brhhappy/ulility/radial_progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  bool loadStatus = true;
  EmployeeCode employeeCode;
  String image;
  File file;
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');

    String urlGetData =
        "${MyConstantCounterCheckIN().domain}getUsers.php?select=true&empid=$empid";
    await Dio().get(urlGetData).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('result>>>>>>>>>$result');
        for (var map in result) {
          setState(() {
            employeeCode = EmployeeCode.fromJson(map);
            image = employeeCode.empImg;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loadStatus) {
      return MyStyle().showProgress();
    } else {
      return RadialProgress(
        child: image == null
            ? AssetPhoto(
                imagePath: 'assets/images/BDMS.png',
                size: Size.fromWidth(100.0),
              )
            : NetworkPhoto(
                imagePath: '${MyConstantRun().domain}ImagesProfile/$image',
                size: Size.fromWidth(100.0),
              ),
      );
    }
  }
}
