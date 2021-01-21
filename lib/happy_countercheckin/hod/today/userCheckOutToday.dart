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
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCheckOutToDay extends StatefulWidget {
  @override
  _UserCheckOutToDayListState createState() => _UserCheckOutToDayListState();
}

class _UserCheckOutToDayListState extends State<UserCheckOutToDay> {
  EmployeeCode employeeCode;
  bool loadUsers = true;
  bool loadStatus = true;
  bool loadProcess = true;
  List<ManagerCounterList> managerCounterlists = [];
  @override
  void initState() {
    super.initState();
    readUserProfile();
    readData();
  }

  Future<void> readUserProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');

    String urlGetData =
        "${MyConstantCounterCheckIN().domain}getUsers.php?select=true&empid=$empid";
    await Dio().get(urlGetData).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('result>>>>>>>>>$result');
        for (var map in result) {
          setState(() {
            employeeCode = EmployeeCode.fromJson(map);
          });
        }
      }
    });
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantCounterCheckIN().domain}getUserCheckOutToDay.php?select=true&empid=$empid';
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ShowBennerCounterCheckIN(size: size),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Text("Check Out".toUpperCase(), style: listtitleStyle),
                SizedBox(
                  width: 20,
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
              'ไม่มีรายการผู้ออกจากการช่วยเหลืองานแผนกในวันนี้',
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
                style: titleStyle,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        width: MediaQuery.of(context).size.width * 0.5,
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
                  managerCounterlists[index].ccSuggestion == null ||
                          managerCounterlists[index].ccSuggestion.isEmpty
                      ? Text('')
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                              'คำติชม: ${managerCounterlists[index].ccSuggestion}',
                              overflow: TextOverflow.fade,
                              style: textStyle),
                        ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      children: [
                        RatingBarIndicator(
                          rating: managerCounterlists[index].ccEvaluate ==
                                      null ||
                                  managerCounterlists[index].ccEvaluate.isEmpty
                              ? 0
                              : double.parse(
                                  '${managerCounterlists[index].ccEvaluate}'),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 18.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
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
                    ],
                  ),
                ],
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyViewImageMessage(
                        managerCounterLists: managerCounterlists[index],
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 30,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: managerCounterlists[index].empImg == null
                        ? AssetImage('assets/images/BDMS.png')
                        : NetworkImage(
                            '${MyConstantRun().domain}ImagesProfile/${managerCounterlists[index].empImg}'),
                  ),
                ),
              ),
              // leading: ClipOval(
              //   child: managerCounterlists[index].empImg == null
              //       ? Image.asset(
              //           "assets/images/BDMS.png",
              //           width: 50,
              //           height: 50,
              //         )
              //       : GestureDetector(
              //           onTap: () {
              //             Navigator.of(context).push(
              //               MaterialPageRoute(
              //                 builder: (context) => MyViewImageMessage(
              //                   managerCounterLists: managerCounterlists[index],
              //                 ),
              //               ),
              //             );
              //           },
              //           child: Image.network(
              //             '${MyConstantRun().domain}ImagesProfile/${managerCounterlists[index].empImg}',
              //             fit: BoxFit.cover,
              //             width: 50,
              //             height: 50,
              //           ),
              //         ),
              // ),
              //trailing: showWaiting(),
            ),
          );
        });
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
              style: smallStyle),
        ],
      ),
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
