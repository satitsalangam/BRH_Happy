import 'dart:io';

import 'package:brhhappy/doctor_screen.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/change_pass_doctor.dart';
import 'package:brhhappy/happy_Run/model/userModel.dart';
import 'package:brhhappy/ulility/asset_image.dart';
import 'package:brhhappy/ulility/file_image.dart';
import 'package:brhhappy/ulility/loadpage.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/my_constants_web.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/opaque_image.dart';
import 'package:brhhappy/ulility/radial_progress.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorCamera extends StatefulWidget {
  @override
  _DoctorCameraState createState() => _DoctorCameraState();
}

class _DoctorCameraState extends State<DoctorCamera> {
  bool loadUsers = true;
  bool loadProcess = true;
  bool loadStatus = true;
  DateTime dateTime;
  Usermodel usermodel;
  File file;
  String imageAvatar;
  // @override
  // void initState() {
  //   super.initState();

  // }
  Future<void> upload() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.get('id');
    String nameImage = 'image/doctor_$id.png';
    print('name>>>>$nameImage, path>>>>${file.path}');

    String urlSaveFile = '${MyConstantWeb().domain}/GoodDoctor/saveImage.php';
    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);
      print('pathFile = ${file.path}, ${map.toString()}');

      FormData formData = FormData.fromMap(map);
      Dio().post(urlSaveFile, data: formData).then((value) {
        print('Response========> $value');
        setState(() async {
          String urlupdate =
              '${MyConstantDoctor().domain}updateImage.php?update=true&id=$id&image=$nameImage';
          await Dio().get(urlupdate).then((value) {
            print(id);
            print(nameImage);
            setState(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorScreen(),
                  ),
                  (route) => false);
            });
          });
        });
      });
    } catch (e) {
      print('error image type');
    }
  }

  Future<void> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker()
          .getImage(source: source, maxHeight: 600.0, maxWidth: 600.0);
      setState(() {
        file = File(object.path);
        print('file>>>>>>>>>>>>$file');
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    OpaqueImage(imageUrl: ''),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // IconButton(
                                  //     icon: Icon(
                                  //       Icons.arrow_back_ios,
                                  //       color: Colors.white,
                                  //     ),
                                  //     onPressed: () {
                                  //       Navigator.pop(context);
                                  //     }),
                                  Text('Bangkok Hospital', style: menuStyle),
                                  IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.lock,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChangePasswordDoctor(),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      color: Colors.pinkAccent.withOpacity(0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipOval(
                                          child: Container(
                                            height: 200,
                                            // width: 90,
                                            child: file == null
                                                ? Image.asset(
                                                    'assets/images/BDMS.png')
                                                : Image.file(file),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white38),
                                            child: IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.camera,
                                                  size: 35.0,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  chooseImage(
                                                      ImageSource.camera);
                                                }),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white38),
                                            child: IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.images,
                                                  size: 35.0,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  chooseImage(
                                                      ImageSource.gallery);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  btnForm()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget btnForm() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        height: 50.0,
        child: RaisedButton(
          onPressed: () {
            if (file == null) {
              normalDialog(context, 'กรุณาเลือกรูปภาพประจำตัว');
            } else {
              upload();
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          padding: EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: 1200.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: Text(
                "Upload Image",
                textAlign: TextAlign.center,
                style: titledoctor_style,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
