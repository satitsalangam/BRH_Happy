import 'dart:convert';
import 'package:brhhappy/happy_Run/model/userModel.dart';
import 'package:brhhappy/happy_Run/users/cameraProfiel.dart';
import 'package:brhhappy/happy_Run/users/users_home.dart';
import 'package:brhhappy/happy_Vehicle/sidebar/sidebar_layout.dart';
import 'package:brhhappy/happy_countercheckin/hod/page/intro_page.dart';
import 'package:brhhappy/happy_countercheckin/hod/sidebar/sidebar_layout.dart';
import 'package:brhhappy/happy_countercheckin/users/sidebar/sidebar_layout.dart';
import 'package:brhhappy/happy_countercheckin/users/user_home.dart';
import 'package:brhhappy/ulility/asset_image.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/network_image.dart';
import 'package:brhhappy/ulility/process_SingOut.dart';
import 'package:brhhappy/ulility/radial_progress.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool loadUsers = true;
  Usermodel usermodel;
  String image, name, titlename, department, status;
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
            image = usermodel.empImg;
            name = usermodel.empPnamefullTh;
            titlename = usermodel.empPnameTh;
            department = usermodel.empDeptdesc;
            status = usermodel.empStatus;
          });
          print(image);
        }
      }
    });
  }

  Future<void> usersToService(Widget myWidget) async {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
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
        title: Center(
          child: Text(
            'BRH HAPPY'.toUpperCase(),
            style: headingTextStyle,
          ),
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
                          EdgeInsets.only(right: 20, left: 20, bottom: 110),
                      height: size.height * 0.25 - 10,
                      decoration: BoxDecoration(
                        color: kTextColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36)),
                      ),
                      child: Container(
                        // color: Colors.red,
                        width: size.width * 1,
                        child: loadUsers
                            ? MyStyle().showProgress()
                            : Column(
                                children: [
                                  Text(
                                    '$titlename $name',
                                    style: titleTextStyle,
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    '$department',
                                    style: titledepartmentTextStyle,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                      ),
                    ),
                    Stack(
                      children: [
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
                        Positioned(
                          right: 115,
                          bottom: 0,
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                    color: Colors.blue.withOpacity(0.3)),
                              ),
                              color: Colors.white54,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CameraProfile(),
                                    ));
                              },
                              child: Icon(
                                Icons.camera,
                                color: Colors.lightBlue,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              status == 'employee'
                  ? showCounterCheckIn(context, size)
                  : showHODCounterCheckIn(context, size),
              //showHappyRun(context, size),
              showVehicle(context, size),
            ],
          ),
        ],
      ),
    );
  }

  Widget showHODCounterCheckIn(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30),
      child: GestureDetector(
        onTap: () {
          usersToService(SideBarHodCheckINLayout());
          // usersToService(IntroPage(
          //   usermodel: usermodel,
          // ));
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
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'Counter Check In'.toUpperCase(),
                  style: listtitleStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showCounterCheckIn(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30),
      child: GestureDetector(
        onTap: () {
          usersToService(SideBarCheckINLayout());
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
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'Counter Check In'.toUpperCase(),
                  style: listtitleStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showVehicle(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30),
      child: GestureDetector(
        onTap: () {
          usersToService(
            SideBarLayout(),
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
                  child: Image.asset('assets/images/ven.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'BRH Happy Vehicle'.toUpperCase(),
                  style: listtitleStyle,
                ),
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
          usersToService(UserHappyRun());
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
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'B+Happy Run'.toUpperCase(),
                  style: listtitleStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
