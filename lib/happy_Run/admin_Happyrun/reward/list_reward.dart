import 'dart:convert';

import 'package:brhhappy/happy_Run/model/listreward.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminRewardList extends StatefulWidget {
  @override
  _AdminRewardListState createState() => _AdminRewardListState();
}

class _AdminRewardListState extends State<AdminRewardList> {
  bool loadStatus = true;
  bool loadProcess = true;
  List<ListReward> listReward = [];
  String id, rewardid, score, empid;
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> normalDialogAppove(
      BuildContext context, String title, ListReward listReward) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        Navigator.pop(context);
        id = listReward.redId;
        print('id>>>$id');
        String url =
            '${MyConstantRun().domain}updateStatusReward.php?isupdate=true&id=$id';
        await Dio().get(url).then(
              (value) => loadStatus ? MyStyle().showProgress() : readData(),
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

  Future<void> normalDialogNoAppove(
      BuildContext context, String title, ListReward listReward) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        Navigator.pop(context);
        empid = listReward.redEmpid;
        print('empid>>>$empid');
        id = listReward.redId;
        print('id>>$id');
        rewardid = listReward.reId;
        print('rewardid>>$rewardid');
        score = listReward.redScoreReward;
        print('score>>>$score');

        print('id>>>$id');
        String url =
            '${MyConstantRun().domain}updateStatusRewardNoApprove.php?isupdate=true&id=$id&reid=$rewardid&empid=$empid&point=$score';
        await Dio().get(url).then(
              (value) => loadStatus ? MyStyle().showProgress() : readData(),
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

  Future<void> readData() async {
    if (listReward.length != 0) {
      listReward.clear();
    }
    String url = '${MyConstantRun().domain}getListRedemption.php?select=true';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          ListReward listRewards = ListReward.fromJson(map);
          setState(() {
            listReward.add(listRewards);
            // listimage.add(listimages);
          });
        }
      } else {
        loadProcess = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loadStatus ? MyStyle().showProgress() : showContent(size);
  }

  Widget showContent(Size size) {
    return Container(
      height: size.height * 0.7,
      child: Swiper(
        itemCount: listReward.length,
        itemWidth: size.width - 2 * 30,
        layout: SwiperLayout.STACK,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              activeSize: 12,
              space: 4,
              activeColor: Colors.pink,
              color: Colors.blueGrey),
        ),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 140.0,
                  ),
                  Card(
                    shadowColor: Colors.blueAccent,
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
                          CircleAvatar(
                            radius: 35,
                            child: CircleAvatar(
                              radius: 33,
                              backgroundImage: NetworkImage(
                                  '${MyConstantRun().domain}ImagesProfile/${listReward[index].empImg}'),
                            ),
                          ),
                          Text(
                            '${listReward[index].empPnameTh} ${listReward[index].empPnamefullTh}',
                            style: textStyle,
                          ),
                          Text(
                            '${listReward[index].redTitleReward}',
                            style: menuTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'ใช้คะแนน :',
                                    style: smallStyle,
                                  ),
                                  Text(
                                    '${listReward[index].redScoreReward}',
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
                                    '1',
                                    style: apporveStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Ink(
                                decoration: ShapeDecoration(
                                    color: Colors.blue.withOpacity(0.5),
                                    shape: CircleBorder()),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.cancel_sharp,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                  splashColor: kTextColor,
                                  onPressed: () {
                                    normalDialogNoAppove(
                                        context,
                                        'คุณต้องการยกเลิกคำขอ ใช่หรือไม่',
                                        listReward[index]);
                                  },
                                ),
                              ),
                              Ink(
                                decoration: ShapeDecoration(
                                    color: Colors.blue.withOpacity(0.5),
                                    shape: CircleBorder()),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.check_circle_sharp,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                  splashColor: kTextColor,
                                  onPressed: () {
                                    normalDialogAppove(
                                        context,
                                        'คุณต้องการอนุมัติ ใช่หรือไม่',
                                        listReward[index]);
                                  },
                                ),
                              ),
                            ],
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
                    radius: 120,
                    child: CircleAvatar(
                      radius: 115,
                      backgroundImage: NetworkImage(
                          '${MyConstantRun().domain}reward/${listReward[index].redImageReward}'),
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
