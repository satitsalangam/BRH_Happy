import 'dart:convert';

import 'package:brhhappy/happy_Run/model/userModel.dart';
import 'package:brhhappy/happy_countercheckin/hod/approveperson/approvelist.dart';
import 'package:brhhappy/happy_countercheckin/hod/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:brhhappy/happy_countercheckin/hod/chart/chart.dart';
import 'package:brhhappy/happy_countercheckin/hod/sidebar/sidebar_layout.dart';
import 'package:brhhappy/happy_countercheckin/hod/today/userCheckOutToday.dart';
import 'package:brhhappy/happy_countercheckin/hod/today/userCheckinToday.dart';
import 'package:brhhappy/happy_countercheckin/hod/totalperson/totalUserDeparment.dart';
import 'package:brhhappy/happy_countercheckin/hod/waithingperspn/requestJob.dart';
import 'package:brhhappy/happy_countercheckin/models/countAll.dart';
import 'package:brhhappy/happy_countercheckin/models/countEvaluate.dart';
import 'package:brhhappy/happy_countercheckin/models/countIsNotNullEvaluate.dart';
import 'package:brhhappy/happy_countercheckin/models/countOutToDay.dart';
import 'package:brhhappy/happy_countercheckin/models/countToday.dart';
import 'package:brhhappy/happy_countercheckin/models/moreEvaluate.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_countercheckin.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget with NavigationStates {
  final Usermodel usermodel;
  IntroPage({Key key, this.usermodel}) : super(key: key);
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Usermodel usermodels;
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
  String today, total, waithing, sumEvaluate, outDay, approve, image;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    findCalate();
    // usermodels = widget.usermodel;
    // image = usermodels.empImg;
  }

  Future<void> findCalate() async {
    setState(() {
      // readCountAll();
      readCountToDay();
      readCountIsNullEvaluate();
      readCountOutToday();
      ismoreEvaluate();
      readCountIsNotNullEvaluate();
    });
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SideBarHodCheckINLayout()),
          (route) => false);
    });
    return null;
  }

  Future<void> ismoreEvaluate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantCounterCheckIN().domain}getUserEvaluate.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadmoreEvaluate = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            moreEvaluate = MoreEvaluate.fromJson(map);
            userEvaluete = double.parse(moreEvaluate.countMoreEvaluate);
            readCountAll();
          });
        }
      }
    });
  }

  String calculate(double userEvaluete, double userallEvaluate) {
    double sumEvaluate = 0;
    sumEvaluate = (userEvaluete * 100) / userallEvaluate;
    var f = new NumberFormat("#,###.0#", 'en_US');
    print('sum>>$sumEvaluate');
    return f.format(sumEvaluate);
  }

  Future<void> readCountOutToday() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantCounterCheckIN().domain}getCountOutToDay.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadCountOutToday = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            countOutToDay = CountOutToDay.fromJson(map);
            outDay = countOutToDay.countOutToDay;
          });
        }
      }
    });
  }

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
            userallEvaluate = double.parse(countAll.countAll);
            sumEvaluate = calculate(userEvaluete, userallEvaluate);
            total = countAll.countAll;
          });
        }
      }
    });
  }

  Future<void> readCountToDay() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantCounterCheckIN().domain}getCountToDay.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadCountToDay = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            countToDay = CountToDay.fromJson(map);
            today = countToDay.countToDay;
          });
        }
      }
    });
  }

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: loadCountAll
          ? MyStyle().showProgress()
          : Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 40),
                    child: Text(
                      'counter check in'.toUpperCase(),
                      style: listtitleStyle,
                    ),
                  ),
                ),
                PieChartSample2(),
                Container(
                  // color: Colors.red,
                  height: size.height * 0.6,
                  child: RefreshIndicator(
                    onRefresh: refreshList,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserCheckInToDay(),
                                      ),
                                    );
                                  },
                                  child: showCardmenu("IN DAY", '$today', "",
                                      Colors.deepOrangeAccent)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserCheckOutToDay(),
                                    ),
                                  );
                                },
                                child: showCardmenu("OUTDAY", "$outDay", "",
                                    Colors.deepPurpleAccent),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            TotalUsersList(),
                                      ),
                                    );
                                  },
                                  child: showCardmenu("TOTAL", "$total",
                                      "$sumEvaluate %", Colors.green)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CheckRequestJob()));
                                },
                                child: showCardmenu("Waith".toUpperCase(),
                                    "$waithing", "", Colors.yellow),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ApproveList(),
                                      ),
                                    );
                                  },
                                  child: showCardmenu(
                                      "APPROVE", "$approve", "", Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          // Cannot be `Alignment.center`
          alignment: Alignment.bottomRight,
          ringColor: Colors.blue.withAlpha(25),
          ringDiameter: 500.0,
          ringWidth: 150.0,
          fabSize: 64.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),
          // Also can use specific color based on wether
          // the menu is open or not:
          // fabOpenColor: Colors.white
          // fabCloseColor: Colors.white
          // These properties take precedence over fabColor
          fabColor: kTextColor,
          fabOpenIcon: Icon(Icons.menu, color: Colors.white),
          fabCloseIcon: Icon(Icons.close, color: Colors.white),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) {
            _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
          },
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(context, "You pressed 1");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kTextColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(FontAwesomeIcons.userCircle, color: Colors.white),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                // _showSnackBar(context, "You pressed 2");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kTextColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(FontAwesomeIcons.scroll, color: Colors.white),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(context, "You pressed 3");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kTextColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MyAdditemVehicle(),
                //   ),
                // );
                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kTextColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(FontAwesomeIcons.chartLine, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showCardmenu(String title, String count, String value, Color color) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent,
                  offset: Offset(1, 1),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.male, size: 50, color: color),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textStyle,
                        ),
                        Text(
                          '$count คน',
                          style: numberStyle,
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    '$value',
                    style: GoogleFonts.pridi(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: txt_style,
        ),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }
}
