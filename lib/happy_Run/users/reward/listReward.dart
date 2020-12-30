import 'dart:convert';

import 'package:brhhappy/happy_Money/model/userModel.dart';
import 'package:brhhappy/happy_Run/model/reward_model.dart';
import 'package:brhhappy/happy_Run/users/users_home.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListReward extends StatefulWidget {
  @override
  _ListRewardState createState() => _ListRewardState();
}

class _ListRewardState extends State<ListReward> {
  List<RewardModel> rewardModels = [];
  bool loadStatus = true;
  bool loadProcess = true;
  bool loadUsers = true;
  Usermodel usermodel;
  String empid, userscore, id, score, title, count, image;
  @override
  void initState() {
    super.initState();
    readData();
    readUsers();
  }

  Future<void> normalDialogReward(
      BuildContext context, String title, RewardModel rewardModel) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String empid = preferences.getString('empid');
        id = rewardModel.reId;
        print('id>>$id');
        score = rewardModel.score;
        print('score>>$score');
        title = rewardModel.reTitle;
        print('title>>$title');
        count = rewardModel.reCount;
        print('count>>$count');
        image = rewardModel.reImge;
        print('image>>$image');
        String url =
            '${MyConstantRun().domain}userRedemption.php?update=true&id=$id&empid=$empid&point=$score&title=$title&imagereward=$image';
        await Dio().get(url).then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHappyRun(),
                ),
              ),
            );
      },
      gradient: LinearGradient(colors: [
        Color.fromRGBO(116, 116, 191, 1.0),
        Color.fromRGBO(52, 138, 199, 1.0)
      ]),
    );
    Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      style: AlertStyle(titleStyle: textStyle),
      buttons: [
        DialogButton(
          child: Text(
            "NO",
            style: textStyle,
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        ),
        dialogButton
      ],
    ).show();
  }

  Future<void> readUsers() async {
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

            userscore = usermodel.empPoint;
          });
        }
      } else {
        setState(() {
          loadProcess = false;
        });
      }
    });
  }

  Future<void> readData() async {
    if (rewardModels.length != 0) {
      rewardModels.clear();
    }
    String url = '${MyConstantRun().domain}getReward.php?select=true';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          RewardModel rewardModel = RewardModel.fromJson(map);
          setState(() {
            rewardModels.add(rewardModel);
          });
        }
      } else {
        setState(() {
          loadProcess = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: blueGrey,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShowBenner(size: size),
              loadStatus ? MyStyle().showProgress() :showNoContent(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget showNoContent(Size size) {
    return loadProcess
        ? showContent(size)
        : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Text(
                'ไม่มีรายการของรางวัล',
                style: titleStyle,
              ),
            ),
          ]);
  }

  Widget showContent(Size size) {
    return Container(
      height: size.height * 0.7,
      child: Swiper(
        itemCount: rewardModels.length,
        itemWidth: size.width - 2 * 64,
        layout: SwiperLayout.STACK,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              activeSize: 12, space: 4, activeColor: Colors.pink),
        ),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 140.0,
                  ),
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            '${rewardModels[index].reTitle}',
                            style: menuTextStyle,
                          ),
                          Text(
                            '${rewardModels[index].reDatails}',
                            style: textStyle,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'คะแนน :',
                                    style: smallStyle,
                                  ),
                                  Text(
                                    '${rewardModels[index].score}',
                                    style: apporveStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'จำนวน :',
                                    style: smallStyle,
                                  ),
                                  Text(
                                    '${rewardModels[index].reCount}',
                                    style: apporveStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          double.parse(userscore) <=
                                      double.parse(rewardModels[index].score) ||
                                  int.parse(rewardModels[index].reCount) == 0
                              ? Ink(
                                  decoration: ShapeDecoration(
                                      color: Colors.blue.withOpacity(0.5),
                                      shape: CircleBorder()),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.remove_shopping_cart,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                    splashColor: kTextColor,
                                    onPressed: () {
                                      normalDialog(context,
                                          'คุณไม่มีสิทธ์แลกของรางวัลชิ้นนี้\nหรือของรางวัลหมดแล้ว');
                                    },
                                  ),
                                )
                              : Ink(
                                  decoration: ShapeDecoration(
                                      color: Colors.blue.withOpacity(0.5),
                                      shape: CircleBorder()),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add_shopping_cart_outlined,
                                      size: 25,
                                      color: Colors.green,
                                    ),
                                    splashColor: kTextColor,
                                    onPressed: () {
                                      normalDialogReward(
                                          context,
                                          'คุณต้องการแลกของรางนี้ ใช่หรือไม่',
                                          rewardModels[index]);
                                    },
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 100,
                      child: CircleAvatar(
                        radius: 95,
                        backgroundImage: NetworkImage(
                            '${MyConstantRun().domain}reward/${rewardModels[index].reImge}'),
                      ),
                    ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
