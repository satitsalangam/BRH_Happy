import 'dart:convert';
import 'package:brhhappy/happy_Run/model/adminModel.dart';
import 'package:brhhappy/ulility/asset_image.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
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

import 'happy_Money/addmin/admin_home.dart';
import 'happy_Run/admin_Happyrun/admin_home.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool loadUsers = true;
  AdminModel adminModel;
  String image, name, usertype;
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userid = preferences.getString('userid');
    String url =
        "${MyConstantRun().domain}getAdminStatus.php?select=true&userid=$userid";
    await Dio().get(url).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            adminModel = AdminModel.fromJson(map);
            usertype = adminModel.userId;
            name = adminModel.userShowname;
          });
          // print(image);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Image(
            image: AssetImage('assets/images/iconB+.png'),
          ),
        ),
        backgroundColor: kTextColor,
        title: Text(
          'BRH HAPPY',
          style: headingTextStyle,
        ),
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
                          EdgeInsets.only(right: 20, left: 20, bottom: 110),
                      height: size.height * 0.25 - 10,
                      decoration: BoxDecoration(
                        color: kTextColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36)),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            loadUsers
                                ? MyStyle().showProgress()
                                : Text(
                                    '$name',
                                    style: headingTextStyle,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: RadialProgress(
                          child: image == null
                              ? AssetPhoto(
                                  imagePath: 'assets/images/BDMS.png',
                                  size: Size.fromWidth(100.0),
                                )
                              : NetworkPhoto(
                                  imagePath:
                                      '${MyConstantRun().domain}ImagesProfile/$image',
                                  size: Size.fromWidth(100.0),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              showHappyMoney(context, size),
              showHappyRun(context, size),          
            ],
          ),
        ],
      ),
    );
  }

  Widget showHappyMoney(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30),
      child: GestureDetector(
        onTap: () {
          usertype.toString() == 'hr'
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Administator(),
                  ),
                )
              : normalDialog(context, 'คุณไม่มีสิทธ์การเข้าถึงหน้านี้');
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
                'B+Happy Money'.toUpperCase(),
                style: listtitleStyle,
              )
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
          usertype.toString() == 'hr'
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeAdminHappyRun(),
                  ),
                )
              : normalDialog(context, 'คุณไม่มีสิทธ์การเข้าถึงหน้านี้');
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
