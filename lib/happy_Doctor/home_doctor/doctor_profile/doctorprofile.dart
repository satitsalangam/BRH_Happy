import 'dart:convert';

import 'package:brhhappy/doctor_screen.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/home_screen.dart';
import 'package:brhhappy/happy_Doctor/model/ratting.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileDoctor extends StatefulWidget {
  @override
  _MyProfileDoctorState createState() => _MyProfileDoctorState();
}

class _MyProfileDoctorState extends State<MyProfileDoctor> {
  bool loadUsers = true;
  UserRatting userRatting;
  String image,
      fristname,
      lastname,
      nameENG,
      doctorID,
      loactionname,
      score,
      status;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> statusToService(Widget myWidget) async {
    // preferences.setString('fullname', userModels.empPnamefullTh);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<void> normalDialogStatusON(BuildContext context, String title) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String id = preferences.getString('id');
        String loactionid = preferences.getString('loaction');
        print(id);
        print(loactionid);
        String url =
            '${MyConstantDoctor().domain}updateStatus.php?isupdate=true&id=$id&locationid=$loactionid&status=manual';
        print(url);
        await Dio().get(url).then((value) {
          setState(() {
            statusToService(
              DoctorHomeScreen(),
            );
          });
        });
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

  Future<void> normalDialogStatusOff(BuildContext context, String title) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String id = preferences.getString('id');
        String loactionid = preferences.getString('loaction');
        print(id);
        print(loactionid);

        String url =
            '${MyConstantDoctor().domain}updateStatus.php?isupdate=true&id=$id&locationid=$loactionid&status=auto';
        await Dio().get(url).then((value) {
          setState(() {
            statusToService(
              DoctorHomeScreen(),
            );
          });
        });
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String loactionid = preferences.getString('loaction');
    print('loaction>>>>$loactionid');
    print('id>>>>>$id');
    String url =
        "${MyConstantDoctor().domain}getDoctorRatting.php?select=true&id=$id&locationid=$loactionid";
    await Dio().get(url).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            userRatting = UserRatting.fromJson(map);
            score = userRatting.drRating;
            image = userRatting.drImg;
            fristname = userRatting.drForename;
            lastname = userRatting.drSurname;
            nameENG = userRatting.drEnglishname;
            doctorID = userRatting.drDoctorid;
            loactionname = userRatting.dlName;
            status = userRatting.dsStatus;
          });
          print('image>>$image');
          print('fristname>>>$fristname');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loadUsers ? MyStyle().showProgress() : showContent(),
    );
  }

  Widget showContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: double.parse(score),
                itemBuilder: (context, index) => Icon(
                  FontAwesomeIcons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemSize: 30.0,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '$score',
                style: smallStyle,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ชื่อ',
                style: titleB_style,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'SATUS',
                    style: loginTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 0),
                    child: status.toString() == 'manual'
                        ? switchOff()
                        : switchON(),
                  ),
                ],
              )
            ],
          ),
          Text(
            '$fristname $lastname',
            style: title_style,
          ),
          Text(
            'NAME',
            style: titleB_style,
          ),
          Text(
            '$nameENG',
            style: titleStyle,
          ),
          Text(
            'เลขใบอนุญาต',
            style: titleB_style,
          ),
          Text(
            '$doctorID',
            style: title_style,
          ),
          Text(
            'แผนก',
            style: titleB_style,
          ),
          Text(
            '$loactionname',
            style: title_style,
          ),
          SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }

  Widget switchOff() {
    return IconButton(
      icon: Icon(
        FontAwesomeIcons.toggleOff,
        size: 40,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          normalDialogStatusOff(context, 'คุณต้องการเปลี่ยน Status ใช่หรือไม่');
        });
      },
    );
  }

  Widget switchON() {
    return IconButton(
      icon: Icon(
        FontAwesomeIcons.toggleOn,
        size: 40,
        color: Colors.green,
      ),
      onPressed: () {
        setState(() {
          normalDialogStatusON(context, 'คุณต้องการเปลี่ยน Status ใช่หรือไม่');
        });
      },
    );
  }
}
