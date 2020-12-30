import 'dart:convert';

import 'package:brhhappy/happy_Run/model/userModel.dart';
import 'package:brhhappy/happy_Run/users/image_runner.dart';
import 'package:brhhappy/happy_Run/users/popular/popular_boy.dart';
import 'package:brhhappy/happy_Run/users/popular/popular_girl.dart';
import 'package:brhhappy/happy_Run/users/showMenu.dart';
import 'package:brhhappy/happy_Run/users/title_with_btn.dart';
import 'package:brhhappy/ulility/curve_shape.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/process_SingOut.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenRun extends StatefulWidget {
  @override
  _HomeScreenRunState createState() => _HomeScreenRunState();
}

class _HomeScreenRunState extends State<HomeScreenRun> {
  bool loadUsers = true;
  Usermodel usermodel;
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
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Container(
        
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[showContent(context)],
          ),
        ),
      ),
    );
  }

  Widget showContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        ClipPath(
          child: Container(
            width: size.width * 1,
            height: size.height * 0.4,
            decoration: BoxDecoration(
               color: Colors.blue.withOpacity(0.8),
              // image: DecorationImage(
              //   image: AssetImage('assets/images/iconB+.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
           clipper: CurveShape(),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ShowMenu(),
            ),
            SizedBox(
              height: 10,
            ),
            TitleWithMoreBtn(
              title: "PopularMen",
              press: () {},
            ),
            PopularBoy(),
            TitleWithMoreBtn(
              title: "PopularWomen",
              press: () {},
            ),
            PopularGirl(),
            TitleWithMoreBtn(
              title: "รายการ",
              press: () {},
            ),
            ShowImageList(),
          ],
        ),
      ],
    );
  }
}
