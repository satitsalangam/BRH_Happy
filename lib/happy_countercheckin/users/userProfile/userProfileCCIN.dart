import 'dart:convert';

import 'package:brhhappy/happy_CounterCheckin/models/employeeCode.dart';
import 'package:brhhappy/happy_countercheckin/models/ratting.dart';
import 'package:brhhappy/happy_countercheckin/users/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:brhhappy/happy_countercheckin/users/userProfile/profileCounterCheckin.dart';
import 'package:brhhappy/ulility/my_constants_countercheckin.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyUserProfileCCIN extends StatefulWidget with NavigationStates {
  @override
  _MyUserProfileCCINState createState() => _MyUserProfileCCINState();
}

class _MyUserProfileCCINState extends State<MyUserProfileCCIN> {
  bool loadStatus = true;
  bool loadRatting = true;
  EmployeeCode employeeCode;
  RattingCheckIn rattingCheckIn;
  String name, preName, department, empidCode, score, departID, ratting;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    readRatting();
  }

  Future<void> readRatting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        "${MyConstantCounterCheckIN().domain}getRatting.php?select=true&empid=$empid";
    await Dio().get(url).then((value) {
      setState(() {
        loadRatting = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            rattingCheckIn = RattingCheckIn.fromJson(map);
            ratting = rattingCheckIn.ratting;
          });
        }
      }
    });
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
            name = employeeCode.empPnamefullTh;
            preName = employeeCode.empPnameTh;
            department = employeeCode.empDeptdesc;
            empidCode = employeeCode.empId;
            departID = employeeCode.empDeptid;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, top: 50),
              child: Container(
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Text(
                          'counter check in'.toUpperCase(),
                          style: listtitleStyle,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: ProfilePicture(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: loadRatting
                            ? MyStyle().showProgress()
                            : RatingBarIndicator(
                                // rating: double.parse(score),
                                rating: double.parse(ratting),
                                itemBuilder: (context, index) => Icon(
                                  FontAwesomeIcons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemSize: 20.0,
                              ),
                      ),
                    ),
                    Text(
                      'รหัสประจำตัว',
                      style: titleB_style,
                    ),
                    Text(
                      '$empidCode',
                      style: titleStyle,
                    ),
                    Text(
                      'ชื่อ-นามสกุล',
                      style: titleB_style,
                    ),
                    Text(
                      '$preName  $name',
                      style: titleStyle,
                    ),
                    Text(
                      'รหัสแผนก',
                      style: titleB_style,
                    ),
                    Text(
                      '$departID',
                      style: titleStyle,
                    ),
                    Text(
                      'แผนก',
                      style: titleB_style,
                    ),
                    Container(
                      width: size.width * 1,
                      child: Text(
                        '$department',
                        style: titleStyle,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
