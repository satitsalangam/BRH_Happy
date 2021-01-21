import 'dart:convert';

import 'package:brhhappy/happy_countercheckin/models/countAll.dart';
import 'package:brhhappy/happy_countercheckin/models/countEvaluate.dart';
import 'package:brhhappy/happy_countercheckin/models/countIsNotNullEvaluate.dart';
import 'package:brhhappy/happy_countercheckin/models/countOutToDay.dart';
import 'package:brhhappy/happy_countercheckin/models/countToday.dart';
import 'package:brhhappy/happy_countercheckin/models/moreEvaluate.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_countercheckin.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;
  bool loadCountAll = true;
  bool loadCountToDay = true;
  bool loadCountOutToday = true;
  bool loadmoreEvaluate = true;
  bool loadIsNotNullEvaluate = true;
  CountIsNotNullEvaluate countIsNotNullEvaluate;
  CountAll countAll;
  CountToDay countToDay;
  CountEvaluate countEvaluate;
  CountOutToDay countOutToDay;
  MoreEvaluate moreEvaluate;
  double userEvaluete, userallEvaluate;
  String today, total, waithing, sumEvaluate, outDay, approve;
  @override
  void initState() {
    super.initState();
    // findCalate();
    readCountAll();
  }

  Future<void> findCalate() async {
    setState(() {
      //readCountToDay();
      // readCountIsNullEvaluate();
      //readCountOutToday();
      // readCountIsNotNullEvaluate();
      // readCountAll();
    });
  }

  // Future<void> readCountOutToday() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String empid = preferences.getString('empid');
  //   String url =
  //       '${MyConstantCounterCheckIN().domain}getCountOutToDay.php?select=true&empid=$empid';
  //   await Dio().get(url).then((value) {
  //     setState(() {
  //       loadCountOutToday = false;
  //     });
  //     if (value.toString() != 'null') {
  //       var result = json.decode(value.data);
  //       print(result);
  //       for (var map in result) {
  //         setState(() {
  //           countOutToDay = CountOutToDay.fromJson(map);
  //           outDay = countOutToDay.countOutToDay;
  //         });
  //       }
  //     }
  //   });
  // }

  Future<void> readCountAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantCounterCheckIN().domain}getCountAll.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadCountAll = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            countAll = CountAll.fromJson(map);
            total = countAll.countAll;
            readCountIsNotNullEvaluate();
          });
        }
      }
    });
  }

  // Future<void> readCountToDay() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String empid = preferences.getString('empid');
  //   String url =
  //       '${MyConstantCounterCheckIN().domain}getCountToDay.php?select=true&empid=$empid';
  //   await Dio().get(url).then((value) {
  //     setState(() {
  //       loadCountToDay = false;
  //     });
  //     if (value.toString() != 'null') {
  //       var result = json.decode(value.data);
  //       print(result);
  //       for (var map in result) {
  //         setState(() {
  //           countToDay = CountToDay.fromJson(map);
  //           today = countToDay.countToDay;
  //         });
  //       }
  //     }
  //   });
  // }

  Future<void> readCountIsNotNullEvaluate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantCounterCheckIN().domain}getCountIsNotNullEvaluate.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadIsNotNullEvaluate = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            countIsNotNullEvaluate = CountIsNotNullEvaluate.fromJson(map);
            approve = countIsNotNullEvaluate.countNotNullEvaluate;
            readCountIsNullEvaluate();
          });
        }
      }
    });
  }

  Future<void> readCountIsNullEvaluate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantCounterCheckIN().domain}getCountEvaluate.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadCountToDay = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            countEvaluate = CountEvaluate.fromJson(map);
            waithing = countEvaluate.countEvaluate;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 20),
        child: loadCountToDay
            ? MyStyle().showProgress()
            : Container(
                decoration: BoxDecoration(
                  boxShadow: [kBoxShadow],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(
                                    touchCallback: (pieTouchResponse) {
                                  setState(() {
                                    if (pieTouchResponse.touchInput
                                            is FlLongPressEnd ||
                                        pieTouchResponse.touchInput
                                            is FlPanEnd) {
                                      touchedIndex = -1;
                                    } else {
                                      touchedIndex =
                                          pieTouchResponse.touchedSectionIndex;
                                    }
                                  });
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 20,
                                sections: showingSections()),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Indicator(
                            color: Colors.blue,
                            text: 'APPROVE',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.green,
                            text: 'TOTAL',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.yellow,
                            text: 'WAITH',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: double.parse(approve),
            title: approve,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: double.parse(waithing),
            title: waithing,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: double.parse(total),
            title: total,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        // case 3:
        //   return PieChartSectionData(
        //     color: const Color(0xff13d38e),
        //     value: 15,
        //     title: '15%',
        //     radius: radius,
        //     titleStyle: TextStyle(
        //         fontSize: fontSize,
        //         fontWeight: FontWeight.bold,
        //         color: const Color(0xffffffff)),
        //   );
        default:
          return null;
      }
    });
  }
}
