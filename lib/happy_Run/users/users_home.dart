import 'dart:convert';

import 'package:brhhappy/happy_Run/model/allScore.dart';
import 'package:brhhappy/happy_Run/model/userModel.dart';
import 'package:brhhappy/happy_Run/users/event/getListEvent.dart';
import 'package:brhhappy/happy_Run/users/message/getListMessage.dart';
import 'package:brhhappy/happy_Run/users/profile/userProfile.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:brhhappy/user_screen%20copy.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'image_runner.dart';
import 'popular/popular_boy.dart';
import 'popular/popular_girl.dart';
import 'showMenu.dart';
import 'title_with_btn.dart';

class UserHappyRun extends StatefulWidget {
  @override
  _UserHappyRunState createState() => _UserHappyRunState();
}

class _UserHappyRunState extends State<UserHappyRun> {
  bool loadUsers = true;
  bool loadScore = true;
  Usermodel usermodel;
  TotalScore totalScore;
  String allscore;
  @override
  void initState() {
    super.initState();
    readData();
    readAllScore();
  }

  Future<void> usersToService(Widget myWidget) async {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      usersToService(UserHappyRun());
    });
    return null;
  }

  Future<void> readAllScore() async {
    String url = "${MyConstantRun().domain}getAllscore.php?select=true";
    await Dio().get(url).then((value) {
      setState(() {
        loadScore = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            totalScore = TotalScore.fromJson(map);
            allscore = totalScore.allscore;
          });
        }
      }
    });
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "B+Happy Run".toUpperCase(),
          style: titleTextStyle,
        ),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset("assets/images/logo.png"),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.home,
              size: 25,
            ),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => UserScreen(),
              );
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
          )
        ],
      ),
      body: Container(
        color: Colors.blueGrey.withOpacity(0.2),
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.45,
                    child: Stack(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(right: 20, left: 20, bottom: 110),
                          height: size.height * 0.25,
                          decoration: BoxDecoration(
                            color: kTextColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                                bottomRight: Radius.circular(36)),
                          ),
                          child: loadUsers
                              ? MyStyle().showProgress()
                              : showProfile(),
                        ),
                        ShowMenu(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 5, left: 20, right: 20),
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width * 1,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [kBoxShadow]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'ร่วมระยะทางทั้งโครงการ : ',
                            style: textStyle,
                          ),
                          loadScore
                              ? MyStyle().showProgress()
                              : Text(
                                  '$allscore กม.',
                                  style: titleStyle,
                                ),
                        ],
                      ),
                    ),
                  ),
                  TitleWithMoreBtn(
                    title: "Popular Men",
                    press: () {},
                  ),
                  PopularBoy(),
                  SizedBox(
                    height: 15,
                  ),
                  TitleWithMoreBtn(
                    title: "Popular Women",
                    press: () {},
                  ),
                  PopularGirl(),
                  SizedBox(
                    height: 15,
                  ),
                  TitleWithMoreBtn(
                    title: "รายการ",
                    press: () {},
                  ),
                  ShowImageList(),
                  TitleWithMoreBtn(
                    title: "message".toUpperCase(),
                    press: () {},
                  ),
                  UserListMessage(),
                  TitleWithMoreBtn(
                    title: "event".toUpperCase(),
                    press: () {},
                  ),
                  UserListEvent(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showProfile() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${usermodel.empPnameTh} ${usermodel.empPnamefullTh}',
              style: titleNameStyle,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      'ลำดับ : ',
                      style: titleNameStyle,
                    ),
                    Text(
                      '${usermodel.rowRanking}',
                      style: titleNameStyle,
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'คะแนน : ',
                      style: titleNameStyle,
                    ),
                    Text(
                      '${usermodel.empPoint}',
                      style: titleNameStyle,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'ระยะทางวิ่งร่วม: ${usermodel.empTotalpoint} กม.',
                  style: titleNameStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyUserProfile(
                  usermodel: usermodel,
                ),
              ),
            );
          },
          child: Container(
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.orange[400],
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage: usermodel.empImg != null
                      ? NetworkImage(
                          "${MyConstantRun().domain}ImagesProfile/${usermodel.empImg}")
                      : usermodel.empPnameTh.toString() == 'นาย'
                          ? AssetImage('assets/images/avatarMan.png')
                          : AssetImage('assets/images/avatarWomen.png')),
            ),
          ),
        ),
      ],
    );
  }
}
