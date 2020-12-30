import 'dart:convert';

import 'package:brhhappy/happy_Run/model/listreward.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryReward extends StatefulWidget {
  @override
  _HistoryRewardState createState() => _HistoryRewardState();
}

class _HistoryRewardState extends State<HistoryReward> {
  List<ListReward> listRewards = [];
  bool loadStatus = true;
  bool loadProcess = true;
  @override
  void initState() {
    super.initState();
    readReward();
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      readReward();
    });
    return null;
  }

  Future<void> readReward() async {
    if (listRewards.length != 0) {
      listRewards.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantRun().domain}getHistoryReward.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          ListReward listReward = ListReward.fromJson(map);
          print(result);
          setState(() {
            listRewards.add(listReward);
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
        child: SafeArea(
          child: Column(
            children: [
              ShowBenner(size: size),
              Container(
                height: size.height * 0.75,
                child: RefreshIndicator(
                  onRefresh: refreshList,
                  child: loadStatus
                      ? MyStyle().showProgress()
                      : showNoContent(size),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showContent(Size size) {
    return ListView.builder(
      itemCount: listRewards.length,
      itemBuilder: (context, index) {
        return Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [kBoxShadow]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: size.width * 0.5,
                        child: Text(listRewards[index].redTitleReward,
                            style: textStyle),
                      ),
                      listRewards[index].redStatus == 'Waiting'
                          ? Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.shieldAlt,
                                  size: 15,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10),
                                Text(listRewards[index].redStatus,
                                    style: waitingStyle),
                              ],
                            )
                          : listRewards[index].redStatus == 'Approve'
                              ? Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.shieldAlt,
                                      size: 15,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 10),
                                    Text(listRewards[index].redStatus,
                                        style: apporveStyle),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.shieldAlt,
                                      size: 15,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      listRewards[index].redStatus,
                                      style: cancelStyle,
                                    ),
                                  ],
                                ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.starHalfAlt,
                            size: 15,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(listRewards[index].redScoreReward,
                              style: textStyle),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.boxOpen,
                            size: 15,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(listRewards[index].redCountReward,
                              style: textStyle),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.calendarAlt,
                            size: 15,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            listRewards[index].redCreatedate,
                            style: smallStyle,
                          ),
                        ],
                      ),
                      // Text(listRewards[index].redCommend.toString(),
                      //     style: textStyle),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    child: CircleAvatar(
                        radius: 48,
                        backgroundImage: NetworkImage(
                            '${MyConstantRun().domain}reward/${listRewards[index].redImageReward}')),
                  ),
                ],
              ),
            ));
      },
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
}
