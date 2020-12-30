import 'dart:convert';

import 'package:brhhappy/happy_CounterCheckin/models/employeeCode.dart';
import 'package:brhhappy/ulility/my_constants_countercheckin.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyUserProfileCCIN extends StatefulWidget {
  @override
  _MyUserProfileCCINState createState() => _MyUserProfileCCINState();
}

class _MyUserProfileCCINState extends State<MyUserProfileCCIN> {
  bool loadStatus = true;
  EmployeeCode employeeCode;
  String name, preName, department, empidCode, score, departID;
  @override
  void initState() {
    // TODO: implement initState
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: Center(
                child: RatingBarIndicator(
                  // rating: double.parse(score),
                  rating: 4.2,
                  itemBuilder: (context, index) => Icon(
                    FontAwesomeIcons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 30.0,
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
    );
  }
}
