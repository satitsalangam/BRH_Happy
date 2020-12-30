import 'dart:convert';

import 'package:brhhappy/happy_Doctor/home_doctor/components/profile_doctor.dart';
import 'package:brhhappy/happy_Doctor/model/loactionDoctor.dart';
import 'package:brhhappy/happy_Doctor/model/userModels.dart';
import 'package:brhhappy/happy_Run/users/users_home.dart';
import 'package:brhhappy/ulility/asset_image.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/my_constants_web.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/network_image.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/process_SingOut.dart';
import 'package:brhhappy/ulility/radial_progress.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'happy_Doctor/home_doctor/home_screen.dart';

class DoctorScreen extends StatefulWidget {
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  bool loadUsers = true;
  bool loadStatus = true;
  UserDoctor userDoctor;
  LoactionDoctor loactionDoctor;
  List data = [];
  String image, name, lastname, id, selectedName;

  @override
  void initState() {
    super.initState();
    
    readData();
    readDepartment();
  }

  Future<void> loactionToService(Widget myWidget) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('loaction', selectedName);

    // preferences.setString('fullname', userModels.empPnamefullTh);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<void> readDepartment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String urlLoad =
        '${MyConstantDoctor().domain}getDepartment.php?select=true&id=$id';
    await Dio().get(urlLoad).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('result>>>>>>>>>>>>$result');

        setState(() {
          data = result;
        });
        print('department>>>>>$result');
        return "success";
      } else {
        // setState(() {
        //   loadProcess = false;
        // });
      }
    });
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String url =
        "${MyConstantDoctor().domain}getProfile.php?select=true&id=$id";
    await Dio().get(url).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            userDoctor = UserDoctor.fromJson(map);
            image = userDoctor.drImg;
            name = userDoctor.drForename;
            lastname = userDoctor.drSurname;
          });
          print('image>>$image');
          print('name>>$name');
          print('lastnem>>$lastname');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: Text(
          'BRH HAPPY'.toUpperCase(),
          style: headingTextStyle,
        ),
        backgroundColor: kTextColor,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.signOutAlt),
            onPressed: () => processSignOut(context),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.height * 0.3,
                child: Stack(
                  children: [
                    Container(
                      width: size.width * 1,
                      padding:
                          EdgeInsets.only(bottom: 110),
                      height: size.height * 0.25 - 10,
                      decoration: BoxDecoration(
                        color: kTextColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loadUsers
                              ? MyStyle().showProgress()
                              : Container(
                                  width: size.width * 1,                           
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '$name $lastname',
                                      style: menuStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Center(
                        child: ProfilePicture(),
                        // child: RadialProgress(
                        //   child: image == null
                        //       ? AssetPhoto(
                        //           imagePath: 'assets/images/BDMS.png',
                        //           size: Size.fromWidth(100.0),
                        //         )
                        //       : NetworkPhoto(
                        //           imagePath:
                        //               '${MyConstantWeb().domain}GoodDoctor/$image',
                        //           size: Size.fromWidth(100.0),
                        //         ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                child: showDepartment(),
              ),
              showDoctor(context, size),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showDepartment() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.greenAccent[100]),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              value: selectedName,
              hint: Text(
                'Select Deparment',
                style: titleStyle,
              ),
              icon: Icon(Icons.arrow_drop_down),
              isExpanded: true,
              // isDense: true,
              items: data.map((list) {
                return DropdownMenuItem(
                  child: Text(
                    list['dl_name'],
                    style: titleStyle,
                  ),
                  value: list['dl_id'].toString(),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedName = value;
                  print('selectedName>>>$selectedName');
                });
              }),
        ),
      ),
    );
  }

  Widget showDoctor(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30),
      child: GestureDetector(
        onTap: () {
          if (selectedName == null) {
            normalDialog(context, 'กรุณาเลือกแผนกที่ต้องการ');
          } else {
            loactionToService(
              DoctorHomeScreen(),
            );
          }
        },
        child: Container(
          width: size.width * 1,
          height: size.height * 0.1,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              boxShadow: [kBoxShadow]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  width: 50,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Text(
                'good doctor'.toUpperCase(),
                style: listtitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showHappyRun(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserHappyRun(),
            ),
          );
        },
        child: Container(
          width: size.width * 1,
          height: size.height * 0.1,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              boxShadow: [kBoxShadow]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  width: 50,
                  child: Image.asset('assets/images/iconB+.png'),
                ),
              ),
              Text(
                'B+Happy Run'.toUpperCase(),
                style: listtitleStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
