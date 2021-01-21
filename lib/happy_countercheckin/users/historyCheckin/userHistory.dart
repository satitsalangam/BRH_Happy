import 'dart:convert';

import 'package:brhhappy/happy_CounterCheckin/models/countercheackin.dart';
import 'package:brhhappy/happy_CounterCheckin/models/employeeCode.dart';
import 'package:brhhappy/happy_CounterCheckin/showBennerCounterCheckIN.dart';
import 'package:brhhappy/happy_CounterCheckin/users/historyCheckin/userchckINmap.dart';
import 'package:brhhappy/happy_CounterCheckin/users/historyCheckin/usercheckOUTmap.dart';
import 'package:brhhappy/happy_countercheckin/users/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:brhhappy/ulility/my_constants_countercheckin.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHistoryCheckList extends StatefulWidget with NavigationStates{
  @override
  _UserHistoryCheckListState createState() => _UserHistoryCheckListState();
}

class _UserHistoryCheckListState extends State<UserHistoryCheckList> {
  bool loadStatus = true;
  bool loadProcess = true;
  bool loadUsers = true;
  EmployeeCode employeeCode;
  String date;
  String image;

  // CounterCheackin counterCheackins;
  List<CounterCheackin> counterCheackin = List();
  @override
  void initState() {
    super.initState();
    readData();
    readUserProfile();
    date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print('date>>>>$date');
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
            image = employeeCode.empImg;
          });
        }
      }
    });
  }

  Future<void> normalDialogDelect(BuildContext context, String titles,
      CounterCheackin counterCheackin) async {
    var dialogButton = DialogButton(
      child: Text(
        "ใช่",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      onPressed: () async {
        print(counterCheackin.ccId);
        Navigator.pop(context);
        String url =
            '${MyConstantCounterCheckIN().domain}addCancel.php?update=true&id=${counterCheackin.ccId}';
        await Dio().get(url).then((value) => readData());
      },
      gradient: LinearGradient(colors: [
        Color.fromRGBO(116, 116, 191, 1.0),
        Color.fromRGBO(52, 138, 199, 1.0)
      ]),
    );
    Alert(
      context: context,
      type: AlertType.warning,
      title: titles,
      style: AlertStyle(titleStyle: TextStyle(fontSize: 15.0)),
      buttons: [
        DialogButton(
          child: Text(
            "ไม่ใช่",
            style: TextStyle(color: Colors.white, fontSize: 20),
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
    if (counterCheackin.length != 0) {
      counterCheackin.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    print('empid>>>$empid');

    String url =
        '${MyConstantCounterCheckIN().domain}getCheckList.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('result>>>>>$result');
        for (var map in result) {
          CounterCheackin counterCheackins = CounterCheackin.fromJson(map);
          setState(() {
            counterCheackin.add(counterCheackins);
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
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 10),
        child: Column(
          children: <Widget>[
            //ShowBennerCounterCheckIN(size: size),
             Center(
              child: Padding(
                padding: const EdgeInsets.only(top:10,bottom: 20),
                child: Text(
                  'counter check in'.toUpperCase(),
                  style: listtitleStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: loadUsers ? MyStyle().showProgress() : showTitle(context),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Text(
                    "ประวัติรายการทั้งหมด",
                    style: textStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.withOpacity(0.5)),
                    child: Center(
                      child: Text(
                        "${counterCheackin.length}",
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
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
      ),
    );
  }

  Widget showNoContent() {
    return loadProcess
        ? showContet()
        : Center(
            child: Text(
              'ยังไม่มีประวัติการช่วยเหลืองาน',
              style: GoogleFonts.prompt(
                  fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          );
  }

  Widget showContet() {
    return ListView.builder(
        itemCount: counterCheackin.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                'รหัสพนักงาน: ${counterCheackin[index].ccEmpid}',
                                style: textStyle,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                'ช่วยแผนก: ${counterCheackin[index].dsDesc}',
                                style: GoogleFonts.pridi(
                                    fontSize: 12.0, color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Row(
                            children: [
                              Text(
                                'คะแนน: ',
                                style: GoogleFonts.pridi(
                                    fontSize: 12.0, color: Colors.black54),
                              ),
                              RatingBarIndicator(
                                rating: counterCheackin[index].ccEvaluate ==
                                            null ||
                                        counterCheackin[index]
                                            .ccEvaluate
                                            .isEmpty
                                    ? 0
                                    : double.parse(
                                        counterCheackin[index].ccEvaluate),
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
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                'วันที่เข้า : ${counterCheackin[index].ccDatein} เวลาที่เข้า : ${counterCheackin[index].ccTimein} น.',
                                style: GoogleFonts.pridi(
                                    fontSize: 12.0, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            counterCheackin[index].ccDateout == null
                                ? showDateNull(index)
                                : showDate(index)
                          ],
                        ),
                        Row(
                          children: [
                            counterCheackin[index].ccSuggestion == null ||
                                    counterCheackin[index]
                                        .ccSuggestion
                                        .isEmpty
                                ? showNull(index)
                                : showSuggestion(index),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            counterCheackin[index].ccDatein == date &&
                                    counterCheackin[index].ccStatus !=
                                        'cancel' &&
                                    counterCheackin[index].ccDateout == null
                                ? showCencel(context, index)
                                : showNull(index),
                            SizedBox(
                              width: 20,
                            ),
                            counterCheackin[index].ccLatCheackin == null
                                ? showNull(index)
                                : showCheckinMaps(context, index),
                            SizedBox(
                              width: 20,
                            ),
                            counterCheackin[index].ccLatCheackout == null
                                ? showNull(index)
                                : showCheckoutMaps(context, index),
                          ],
                        )
                      ],
                    ),
                    counterCheackin[index].ccDateout == null
                        ? showCheackOut(context, index)
                        : showCheackIn(context, index)
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget showSuggestion(int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Text(
        'คำติชม: ${counterCheackin[index].ccSuggestion}',
        overflow: TextOverflow.clip,
        style: GoogleFonts.pridi(fontSize: 12.0, color: Colors.black54),
      ),
    );
  }

  Widget showNull(int index) {
    return Text(
      '',
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.pridi(fontSize: 12.0, color: Colors.black54),
    );
  }

  Widget showDate(int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Text(
        'วันที่ออก : ${counterCheackin[index].ccDateout} เวลาที่ออก : ${counterCheackin[index].ccTimeout} น.',
        style: GoogleFonts.pridi(
          fontSize: 12.0,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget showDateNull(int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Text(
        'วันที่ออก :_ _:_ _:_ _ เวลาที่ออก :_ _:_ _:_ _ น.',
        style: GoogleFonts.pridi(
          fontSize: 12.0,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget showCencel(BuildContext context, int index) {
    return Column(
      children: [
        IconButton(
            icon: Icon(
              FontAwesomeIcons.timesCircle,
              color: Colors.blueAccent,
              size: 28,
            ),
            onPressed: () {
              normalDialogDelect(
                  context,
                  'คุณต้องการลบข้อมูลCheckin ใช่หรือไม่',
                  counterCheackin[index]);
            }),
        Text(
          'cancel',
          style: GoogleFonts.pridi(
            fontSize: 12.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget showCheackOut(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFCDDDD),
          ),
          child: Icon(
            Icons.warning,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget showCheackIn(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFCAF8E0),
          ),
          child: Icon(
            Icons.check,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget showTitle(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
                radius: 35,
                child: CircleAvatar(
                  radius: 34.5,
                  backgroundImage: employeeCode.empImg == null
                      ? AssetImage('asset/images/BDMS.png')
                      : NetworkImage(
                          '${MyConstantRun().domain}ImagesProfile/$image'),
                )),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                'ชื่อ : ${employeeCode.empPnameTh} ${employeeCode.empPnamefullTh}',
                style: textStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                'รหัสกลุ่ม : ${employeeCode.empPaygroup}',
                style: GoogleFonts.pridi(fontSize: 12.0, color: Colors.black54),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                'รหัสแผนก : ${employeeCode.empDeptid}',
                style: GoogleFonts.pridi(fontSize: 12.0, color: Colors.black54),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                'ตำแหน่ง : ${employeeCode.empPosdesc}',
                style: GoogleFonts.pridi(fontSize: 12.0, color: Colors.black54),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
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
                      builder: (context) => UserInLoactionMaps(
                        counterCheackin: counterCheackin[index],
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
                      builder: (context) => UserOutLoactionMaps(
                        counterCheackin: counterCheackin[index],
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
