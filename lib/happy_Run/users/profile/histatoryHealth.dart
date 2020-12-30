import 'dart:convert';

import 'package:brhhappy/happy_Run/model/userHealth.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistatoryHealth extends StatefulWidget {
  @override
  _HistatoryHealthState createState() => _HistatoryHealthState();
}

class _HistatoryHealthState extends State<HistatoryHealth> {
  List<UserHealth> userHealths = [];
  bool loadStatus = true;
  @override
  void initState() {
    super.initState();
    readHealth();
  }

  Future<void> readHealth() async {
    if (userHealths.length != 0) {
      userHealths.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantRun().domain}getHealth.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          UserHealth userHealth = UserHealth.fromJson(map);
          print(result);
          setState(() {
            userHealths.add(userHealth);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShowBenner(size: size),
            Container(
              height: size.height * 0.8,
              child: ListView.builder(
                itemCount: userHealths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.height * 0.12,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [kBoxShadow]),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 27,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: userHealths[index]
                                          .empImg
                                          .toString() ==
                                      'null'
                                  ? AssetImage('assets/images/avatarMan.png')
                                  : NetworkImage(
                                      '${MyConstantRun().domain}ImagesProfile/${userHealths[index].empImg}'),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Icon(
                                      Icons.supervised_user_circle_outlined,
                                      size: 20,
                                      color: Colors.blueGrey[200],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${userHealths[index].empPnameTh} ${userHealths[index].empPnamefullTh}',
                                    style: textStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      size: 20,
                                      color: Colors.blueGrey[200],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${userHealths[index].heBmi}',
                                    style: textStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.eco_outlined,
                                      size: 20,
                                      color: Colors.blueGrey[200],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${userHealths[index].heFix}',
                                    style: textStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.date_range_outlined,
                                      size: 20,
                                      color: Colors.blueGrey[200],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${userHealths[index].heCratedate}',
                                    style: smallStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
