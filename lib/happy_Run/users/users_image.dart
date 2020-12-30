import 'dart:convert';
import 'dart:io';

import 'package:brhhappy/happy_Run/model/image_run.dart';
import 'package:brhhappy/happy_Run/model/listImage.dart';
import 'package:brhhappy/ulility/addicon.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/loadpage.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRuner extends StatefulWidget {
  @override
  _UserRunerState createState() => _UserRunerState();
}

class _UserRunerState extends State<UserRuner> {
  ImageRun imageRun;
  DateTime dateTime;
  File file;
  bool loadStatus = true;
  bool loadImage = true;
  bool loadProcess = true;
  var timer = Duration(hours: 0);
  String empid, status, distance, image, date, id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.now();
  }

  
  Future<void> upload(String id) async {
    String nameImage = 'id.$id,runner.png';
    print('name>>>>$nameImage, path>>>>${file.path}');

    String urlSaveFile = '${MyConstantRun().domain}saveImage.php';
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
              '${MyConstantRun().domain}updateImage.php?isupdate=true&id=$id&image=$nameImage';
          await Dio().get(urlupdate).then((value) {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadPage(),
                ),
              );
            });
          });
        });
      });
    } catch (e) {
      print('error image type');
    }
  }

  Future<void> readImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.get('empid');
    print(empid);
    String url =
        "${MyConstantRun().domain}getImageRunner.php?select=true&empid=$empid";
    await Dio().get(url).then((value) {
      setState(() {
        loadImage = false;
      });

      if (value.toString() != null) {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            imageRun = ImageRun.fromJson(map);
            id = imageRun.imId;
          });
        }
      } else {}
    });

    setState(() {
      upload(id);
    });
  }

  Future<void> addRunnerImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.get('empid');
    print('empid$empid');
    print('status$status');
    print('distance$distance');
    print('timer$timer');
    print('image$image');
    print('date$date');
    String url =
        "${MyConstantRun().domain}addRunner.php?isAdd=true&empid=$empid&distance=$distance&timer=$timer&image=$image&date=$dateTime";

    Response response = await Dio().get(url).then((value) {
      setState(() {
        showProcessingDiglog(context);
        
        readImage();
      });
      normalDialogSucceed(context, 'ทำการอัพโหลดสำเร็จ');
    });
    //print(response);
  }

  Future<void> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker()
          .getImage(source: source, maxHeight: 800.0, maxWidth: 800.0);
      setState(() {
        file = File(object.path);
        print('file>>>>>>>>>>>>$file');
      });
    } catch (e) {}
  }

  Future<void> chooseDate() async {
    DateTime chooseDateTime = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (chooseDateTime != null) {
      setState(() {
        dateTime = chooseDateTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShowBenner(size: size),
            SizedBox(
              height: size.height * 0.7,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              chooseImage(ImageSource.gallery);
                            });
                          },
                          child: IconsCard(icon: "assets/images/image.png"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: Container(
                      height: size.height * 0.75,
                      width: size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(63),
                          bottomLeft: Radius.circular(63),
                          topRight: Radius.circular(63),
                          bottomRight: Radius.circular(63),
                        ),
                        boxShadow: [kBoxShadow],
                        image: DecorationImage(
                          alignment: Alignment.centerLeft,
                          image: file == null
                              ? AssetImage("assets/images/gpsmap.jpg")
                              : FileImage(file),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              constraints: BoxConstraints.tight(
                Size(MediaQuery.of(context).size.width * 1, 90.0),
              ),
              child: TextFormField(
                style: menuTextStyle,
                onChanged: (value) => distance = value.trim(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  prefixText: 'ระยะ : ',
                  prefixStyle: titleStyle,
                  labelText: "ระยะทางการวิ่ง",
                  labelStyle: titleStyle,
                  suffixText: 'กิโลเมตร',
                  suffixStyle: titleStyle,
                  // hintText: "กรุณากรอกระยะทางที่วิ่งได้",
                  // hintStyle: numberStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            distanceTimer(),
            showData(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (file == null) {
                      normalDialog(context, 'กรุณาเลือกรูปภาพของคุณ');
                    } else if (distance == null ||
                        distance.isEmpty ||
                        timer == null ||
                        timer.inMinutes == 0 ||
                        dateTime == null) {
                      normalDialog(context, 'กรุณากรอกรายละเอียดให้ครบถ้วน');
                    } else {
                      addRunnerImage();
                    }
                  });
                },
                child: Material(
                  elevation: 10.0,
                  shadowColor: primary,
                  color: primary,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: size.width,
                    height: size.width * 0.15,
                    child: Center(
                      child: Text('UP LOAD', style: titledoctor_style),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget distanceTimer() {
    return ListTile(
      subtitle: Text(
        'กรุณาเลือกเวลาการวิ่ง',
        style: titleStyle,
      ),
      onLongPress: () {},
      leading: Icon(
        Icons.timer,
        color: Colors.blue,
        size: 40,
      ),
      title: Text(
        '${timer.inMinutes} นาที',
        style: menuTextStyle,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext builder) {
              return Container(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration: timer,
                  onTimerDurationChanged: (value) {
                    setState(() {
                      timer = value;
                    });
                  },
                ),
              );
            });
      },
    );
  }

  Widget showData() {
    return ListTile(
      subtitle: Text('กรุณาเลือกวันวิ่ง', style: titleStyle),
      onLongPress: () {},
      leading: Icon(
        Icons.date_range,
        color: Colors.blue,
        size: 40,
      ),
      title: Text(
        '${dateTime.day}-${dateTime.month}-${dateTime.year}',
        style: menuTextStyle,
      ),
      trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white),
      onTap: () {
        chooseDate();
      },
    );
  }
}
