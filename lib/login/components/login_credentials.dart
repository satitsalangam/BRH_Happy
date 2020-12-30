import 'dart:convert';

import 'package:brhhappy/admin_screen.dart';
import 'package:brhhappy/doctor_screen.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/home_screen.dart';
import 'package:brhhappy/happy_Doctor/model/userModels.dart';
import 'package:brhhappy/happy_Money/model/money_slip.dart';
import 'package:brhhappy/happy_Run/model/adminModel.dart';
import 'package:brhhappy/happy_Run/model/userModel.dart';
import 'package:brhhappy/happy_Run/users/home_screen.dart';
import 'package:brhhappy/happy_Run/users/users_home.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:brhhappy/user_screen%20copy.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCredentials extends StatefulWidget {
  @override
  _LoginCredentialsState createState() => _LoginCredentialsState();
}

class _LoginCredentialsState extends State<LoginCredentials> {
  bool loadProcess = true; //Add Process
  bool loadmoney = true;
  bool loadStatus = true;
  double screenHeight;
  String username, password;
  Usermodel usermodel;
  UserDoctor userDoctor;
  AdminModel adminModel;
  Money moneys;
  String money, usertype;

  @override
  void initState() {
    super.initState();
    // totalmoney();
    // usertype = 'user';
    usertype = 'doctor';
    usercheckLogin();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  Future<void> usercheckLogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString('usertype');
      String adminType = preferences.getString('admintype');
      // String adminchoseType = preferences.getString('admintype');
      print('uerstype>>>>>>>$chooseType');
      print('admintype>>>>>>>$adminType');

      if (chooseType != null || adminType != null) {
        if (chooseType.toString() == 'employee' ||
            chooseType.toString() == 'hod') {
          // showProcessingDiglog(context);
          print(chooseType);
          routoService(UserScreen());
        } else if (adminType.toString() == 'admin') {
          routoService(AdminScreen());
          print('testadmin');
        } else if (chooseType.toString() == 'doctor') {
          routoService(DoctorScreen());
        }
      }
    } catch (e) {}
  }

  Future<void> doctorcheckAuthen() async {
    print('doctorid>>$username');
    print('doctorpass>>$password');
    String url =
        '${MyConstantDoctor().domain}doctorLogin.php?Login=true&username=$username&password=$password';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      print('result>>$result');
      for (var map in result) {
        UserDoctor userDoctor = UserDoctor.fromJson(map);
        setState(() {
          showProcessingDiglog(context);
          doctorToService(DoctorScreen(), userDoctor);
        });
      }
    } catch (e) {
      normalDialog(context, 'ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง');
    }
  }

  Future<void> usercheckAuthen() async {
    print(username);
    print(password);
    String url =
        '${MyConstantRun().domain}usersLogin.php?empid=$username&Login=true&emppass=$password';
    try {
      Response response = await Dio().get(url);
      print('res = $response');
      var result = json.decode(response.data);
      print('result>>>>>>>>$result');
      for (var map in result) {
        Usermodel usermodel = Usermodel.fromJson(map);
        String empdepthod1 = usermodel.depthod1;

        if (empdepthod1 != null || empdepthod1.isNotEmpty) {
          if (empdepthod1 == 'user') {
            showProcessingDiglog(context);
            routeToService(UserScreen(), usermodel);
          } else {
            // showProcessingDiglog(context);
            // routeToService(ManagerHomePage(), usermodel);
          }
        }
      }
    } catch (e) {
      normalDialog(context, 'ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง');
    }
  }

  void routoService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => myWidget));
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<void> admincheckAuthen() async {
    String url =
        '${MyConstantRun().domain}adminLogin.php?Login=true&empid=$username&emppass=$password';
    print(username);
    print(password);

    // normalDialog(context, url);
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      print(result);
      for (var map in result) {
        AdminModel adminModel = AdminModel.fromJson(map);
        String chooseType = adminModel.userIdadd;
        if (chooseType == 'admin') {
          adminToService(AdminScreen(), adminModel);
          // routeToService(Administator(), usermodel);
        } else {
          normalDialog(context, 'ไม่มีข้อมูลของผู้ใช้งาน');
        }
      }
    } catch (e) {
      normalDialog(context, 'ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง');
    }
  }

  Future<void> adminToService(Widget myWidget, AdminModel adminModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userid', adminModel.userId);
    preferences.setString('admintype', 'admin');
    preferences.setString('status', adminModel.userStatus);
    // preferences.setString('fullname', userModels.empPnamefullTh);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<void> doctorToService(Widget myWidget, UserDoctor userDoctor) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('nameTH', userDoctor.drForename);
    preferences.setString('surnameTH', userDoctor.drSurname);
    preferences.setString('doctorid', userDoctor.drUsername);
    preferences.setString('usertype', 'doctor');
    preferences.setString('id', userDoctor.drId);
    preferences.setString('fullnameENG', userDoctor.drEnglishname);
    preferences.setString('IMG', userDoctor.drImg);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<void> routeToService(Widget myWidget, Usermodel userModels) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('empid', userModels.empId);
    preferences.setString('usertype', userModels.empStatus);
    preferences.setString('prename', userModels.empPnameTh);
    preferences.setString('fullname', userModels.empPnamefullTh);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please Log In', style: titledoctor_style),
          SizedBox(
            height: size.height * 0.03,
          ),
          Material(
            elevation: 10.0,
            color: white,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              style: titleB_style,
              onChanged: (value) => username = value.trim(),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(
                    vertical: appPadding * 0.75, horizontal: appPadding),
                fillColor: white,
                hintText: 'Username',
                hintStyle: title_style,
                suffixIcon: Icon(
                  Icons.person_add_sharp,
                  size: 25.0,
                  color: black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Material(
            elevation: 10.0,
            color: white,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              obscureText: true,
              style: titleB_style,
              onChanged: (value) => password = value.trim(),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(
                    vertical: appPadding * 0.75, horizontal: appPadding),
                fillColor: Colors.white,
                hintText: 'Password',
                hintStyle: title_style,
                suffixIcon: Icon(
                  Icons.lock_outline,
                  size: 25.0,
                  color: black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // showUser(),
              showDoctor(),
              showAdmin()
            ],
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (usertype == null || usertype.isEmpty) {
                  normalDialog(context, 'กรุณาเลือกประเภทผู้ใช้งาน');
                } else if (username == null ||
                    username.isEmpty ||
                    password == null ||
                    password.isEmpty) {
                  normalDialog(context, 'กรุณากรอกข้อมูล USER และ PASSWORD');
                } else {
                  if (usertype == 'user') {
                    print(usertype);
                    usercheckAuthen();
                  } else if (usertype == 'doctor') {
                    print(usertype);
                    doctorcheckAuthen();
                  } else {
                    print(usertype);
                    admincheckAuthen();
                  }
                }
              });
            },
            child: Material(
              elevation: 10.0,
              shadowColor: primary,
              color: kTextColor,
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                width: size.width,
                height: size.width * 0.15,
                child: Center(
                  child: Text('Log In', style: titleTextStyle),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showAdmin() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
              value: 'administator',
              groupValue: usertype,
              onChanged: (value) {
                setState(() {
                  usertype = value;
                });
              }),
          Text(
            'ผู้ดูแลระบบ',
            style: textStyle,
          ),
        ]);
  }

  Widget showUser() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
              value: 'user',
              groupValue: usertype,
              onChanged: (value) {
                setState(() {
                  usertype = value;
                });
              }),
          Text(
            'ผู้ใช้ทั่วไป',
            style: textStyle,
          ),
        ]);
  }

  Widget showDoctor() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
              value: 'doctor',
              groupValue: usertype,
              onChanged: (value) {
                setState(() {
                  usertype = value;
                });
              }),
          Text(
            'แพทย์',
            style: textStyle,
          ),
        ]);
  }
}
