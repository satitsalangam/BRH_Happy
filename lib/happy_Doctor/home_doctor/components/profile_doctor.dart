import 'dart:convert';
import 'package:brhhappy/happy_Doctor/home_doctor/cameraProfiel.dart';
import 'package:brhhappy/happy_Doctor/model/userProfile.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/my_constants_web.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
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
        "${MyConstantDoctor().domain}getProfile.php?select=true&id=$id";
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
                    height: 150,
                    // width: 90,
                    child: Image.network(
                        '${MyConstantWeb().domain}GoodDoctor/$image'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 35,
              width: 35,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Colors.white54,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorCamera(),
                      ));
                },
                child: Icon(
                  Icons.camera,
                  color: Colors.lightBlue,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
