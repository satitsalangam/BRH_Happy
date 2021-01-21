import 'dart:convert';

import 'package:brhhappy/happy_countercheckin/hod/totalperson/locationInmap.dart';
import 'package:brhhappy/happy_countercheckin/hod/totalperson/locationOutmap.dart';
import 'package:brhhappy/happy_countercheckin/hod/totalperson/viewImageTotalList.dart';
import 'package:brhhappy/happy_countercheckin/models/employeeCode.dart';
import 'package:brhhappy/happy_countercheckin/models/managercounterlist.dart';
import 'package:brhhappy/happy_countercheckin/showBennerCounterCheckIN.dart';
import 'package:brhhappy/ulility/my_constants_countercheckin.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckRequestJob extends StatefulWidget {
  @override
  _CheckRequestJobState createState() => _CheckRequestJobState();
}

class _CheckRequestJobState extends State<CheckRequestJob> {
  String evaluate;
  double point;
  List<ManagerCounterList> managerCounterlists = List();
  bool loadStatus = true;
  bool loadProcess = true;
  bool loadUsers = true;
  EmployeeCode employeeCode;
  @override
  void initState() {
    super.initState();
    readData();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  Future<void> readData() async {
    if (managerCounterlists.length != 0) {
      managerCounterlists.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantCounterCheckIN().domain}getListUserDeparment.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        // print('value>>>>>>>>>>>>>>$value');
        var result = json.decode(value.data);
        print('result>>>>>>>>>>>>>$result');
        for (var map in result) {
          ManagerCounterList managerCounterlist =
              ManagerCounterList.fromJson(map);
          setState(() {
            managerCounterlists.add(managerCounterlist);
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
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ShowBennerCounterCheckIN(size: size),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Text("รายการที่รอการอนุมัติ", style: listtitleStyle),
                SizedBox(
                  width: 20,
                ),
                // Container(
                //   width: 25,
                //   height: 25,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.red.withOpacity(0.4),
                //   ),
                //   child: Center(
                //     child: Text(
                //       "${managerCounterlists.length}",
                //       style: textStyle,
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                Spacer(),
                Text(
                  "NEW",
                  style: GoogleFonts.pridi(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ),
          Expanded(
              child: loadStatus ? MyStyle().showProgress() : showNoContent()),
        ],
      ),
    );
  }

  Widget showNoContent() {
    return loadProcess
        ? showCentent()
        : Center(
            child: Text(
              'ยังไม่มีรายการผู้เข้ามาช่วยเหลืองาน',
              style: GoogleFonts.prompt(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
          );
  }

  Widget showCentent() {
    return ListView.builder(
        itemCount: managerCounterlists.length,
        itemBuilder: (context, index) {
          return Card(
            // color: Colors.white60,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: ListTile(
              title: Text(
                '${managerCounterlists[index].empPnameTh} ${managerCounterlists[index].empPnamefullTh}',
                style: textStyle,
              ),
              subtitle: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_city,
                        size: 15,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: Text("${managerCounterlists[index].empDeptdesc}",
                            overflow: TextOverflow.ellipsis, style: textStyle),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 15,
                          color: Colors.green,
                        ),
                        Text(
                            "${managerCounterlists[index].ccDatein} ${managerCounterlists[index].ccTimein}",
                            style: smallStyle),
                      ],
                    ),
                  ),
                  managerCounterlists[index].ccDateout == null
                      ? Text('')
                      : showCheckin(context, index),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.7,
                  //   child: Row(
                  //     children: [
                  //       RatingBarIndicator(
                  //         rating: 0,
                  //         itemBuilder: (context, index) => Icon(
                  //           Icons.star,
                  //           color: Colors.amber,
                  //         ),
                  //         itemCount: 5,
                  //         itemSize: 18.0,
                  //         direction: Axis.horizontal,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      managerCounterlists[index].ccLatCheackin == null ||
                              managerCounterlists[index].ccLatCheackin.isEmpty
                          ? Text('')
                          : showCheckinMaps(context, index),
                      managerCounterlists[index].ccLatCheackout == null ||
                              managerCounterlists[index].ccLatCheackout.isEmpty
                          ? Text('')
                          : showCheckoutMaps(context, index),
                      managerCounterlists[index].ccDateout == null ||
                              managerCounterlists[index].ccDateout.isEmpty
                          ? Text('')
                          : showApprove(context, index)
                    ],
                  ),
                ],
              ),
              leading: ClipOval(
                child: managerCounterlists[index].empImg == null
                    ? Image.asset(
                        "assets/images/BDMS.png",
                        width: 50,
                        height: 50,
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MyViewImageMessage(
                                managerCounterLists: managerCounterlists[index],
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          '${MyConstantRun().domain}ImagesProfile/${managerCounterlists[index].empImg}',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              trailing: managerCounterlists[index].ccDateout == null
                  ? showWaiting()
                  : showComplete(context, index),
            ),
          );
        });
  }

  Widget showComplete(context, index) {
    return SizedBox(
      width: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showWaiting() {
    return SizedBox(
      width: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showCheckin(BuildContext context, int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            size: 15,
            color: Colors.red,
          ),
          Text(
            "${managerCounterlists[index].ccDateout} ${managerCounterlists[index].ccTimeout}",
            style: smallStyle,
          ),
        ],
      ),
    );
  }

  Widget showApprove(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: [
            IconButton(
                icon:
                    Icon(FontAwesomeIcons.star, size: 28, color: Colors.yellow),
                onPressed: () {
                  double score = 0;
                  // point = 1;
                  showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  child: CircleAvatar(
                                    radius: 44,
                                    backgroundImage: managerCounterlists[index]
                                                    .empImg ==
                                                null ||
                                            managerCounterlists[index]
                                                .empImg
                                                .isEmpty
                                        ? AssetImage('assets/images/BDMS.png')
                                        : NetworkImage(
                                            '${MyConstantRun().domain}ImagesProfile/${managerCounterlists[index].empImg}'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${managerCounterlists[index].empPnameTh} ${managerCounterlists[index].empPnamefullTh}',
                                  style: titleStyle,
                                ),
                                Text(
                                  'แผนก :${managerCounterlists[index].empDeptdesc}',
                                  overflow: TextOverflow.ellipsis,
                                  style: departmentStyle,
                                ),
                                RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    score = rating;
                                    print(rating);
                                  },
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       right: 45, left: 45),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceAround,
                                //     children: [
                                //       IconButton(
                                //           icon: Icon(
                                //             Icons.add_circle,
                                //             size: 40,
                                //             color: Colors.green,
                                //           ),
                                //           onPressed: () {
                                //             setState(() {
                                //               if (point < 5) {
                                //                 point++;
                                //                 print('point>>>$point');
                                //               }
                                //             });
                                //           }),
                                //       Text(
                                //         point.toString(),
                                //         style: GoogleFonts.pridi(
                                //             fontSize: 20.0,
                                //             color: Colors.black45),
                                //       ),
                                //       IconButton(
                                //           icon: Icon(
                                //             Icons.remove_circle,
                                //             size: 40,
                                //             color: Colors.red,
                                //           ),
                                //           onPressed: () {
                                //             if (point > 1) {
                                //               setState(() {
                                //                 point--;
                                //                 print('point>>>$point');
                                //               });
                                //             }
                                //           })
                                //     ],
                                //   ),
                                // ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  minLines: 1,
                                  maxLines: 4,
                                  style: GoogleFonts.pridi(
                                      fontSize: 12.0, color: Colors.black45),
                                  decoration: InputDecoration(
                                      // border: InputBorder.none,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      labelText: 'คำติชม'),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 150,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      print('point>>$score');
                                      String urlUpdate =
                                          '${MyConstantCounterCheckIN().domain}updateEvaluate.php?isupdate=true&id=${managerCounterlists[index].ccId}&evaluate=$score';
                                      Dio().get(urlUpdate).then((value) =>
                                          loadStatus
                                              ? MyStyle().showProgress()
                                              : readData());
                                    },
                                    child: Text(
                                      "บันทึกข้อมูล",
                                      style: GoogleFonts.pridi(
                                          color: Colors.white),
                                    ),
                                    color: const Color(0xFF1BC0C5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Text(
              'Evaluate',
              style: GoogleFonts.pridi(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget showCheckinMaps(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: [
            IconButton(
                icon: Icon(FontAwesomeIcons.streetView,
                    size: 28, color: Colors.green),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LocationInMaps(
                        managerCounterlists: managerCounterlists[index],
                      ),
                    ),
                  );
                }),
            Text(
              'Check in',
              style: GoogleFonts.pridi(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget showCheckoutMaps(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: [
            IconButton(
                icon: Icon(FontAwesomeIcons.streetView,
                    size: 28, color: Colors.redAccent),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LocationOutMaps(
                        managerCounterlists: managerCounterlists[index],
                      ),
                    ),
                  );
                }),
            Text(
              'Check out',
              style: GoogleFonts.pridi(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
