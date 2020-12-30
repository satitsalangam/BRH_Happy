import 'dart:convert';
import 'package:brhhappy/happy_Doctor/home_doctor/cameraProfiel.dart';
import 'package:brhhappy/happy_Doctor/model/userProfile.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/my_constants_web.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageDoctor extends StatefulWidget {
  @override
  _ImageDoctorState createState() => _ImageDoctorState();
}

class _ImageDoctorState extends State<ImageDoctor> {
  bool loadUsers = true;
  UserProfileDoctor userProfileDoctor;
  String image;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String loactionid = preferences.getString('loaction');
    print('loaction>>>>$loactionid');
    String url =
        "${MyConstantDoctor().domain}getProfileDoctor.php?select=true&id=$id&locationid=$loactionid";
    await Dio().get(url).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            userProfileDoctor = UserProfileDoctor.fromJson(map);
            image = userProfileDoctor.drImg;
          });
          print('image>>$image');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loadUsers) {
      return MyStyle().showProgress();
    } else {
      return Stack(
        children: [
          ClipOval(
            child: Container(
              color: Colors.pinkAccent.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipOval(
                  child: Container(
                    height: 110,
                    // width: 90,
                    child: Image.network(
                        '${MyConstantWeb().domain}GoodDoctor/$image'),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
