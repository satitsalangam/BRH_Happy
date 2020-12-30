import 'dart:convert';
import 'dart:io';

import 'package:brhhappy/happy_Run/model/message_run.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/loadpage.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminEvent extends StatefulWidget {
  @override
  _AdminEventState createState() => _AdminEventState();
}

class _AdminEventState extends State<AdminEvent> {
  File file;
  String title, detail, url, nameimage, id;
  bool loadData = true;
  Messagerun messagerun;
  Future<void> upload(String id) async {
    String nameImage = 'id.$id,event.png';
    print('name>>>>$nameImage, path>>>>${file.path}');

    String urlSaveFile = '${MyConstantRun().domain}saveEvent.php';

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
              '${MyConstantRun().domain}updateMessage.php?isupdate=true&image=$nameImage&id=$id';
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

  Future<void> readData() async {
    String url = '${MyConstantRun().domain}getMessageRun.php?select=true';
    await Dio().get(url).then((value) {
      setState(() {
        loadData = false;
      });
      if (value.toString() != null) {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            messagerun = Messagerun.fromJson(map);
            id = messagerun.runMeid;
          });
        }
      } else {}
    });
    setState(() {
      upload(id);
    });
  }

  Future<void> addEventRun() async {
    print(title);
    print(detail);
    print(url);
    String urlmessage =
        '${MyConstantRun().domain}addEvent.php?isAdd=true&title=$title&detail=$detail&url=$url';
    Response response = await Dio().get(urlmessage).then((value){
      setState(() {
        readData();
        showProcessingDiglog(context);
      });
    });
    print(response);
  }

  Future<void> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker()
          .getImage(source: source, maxHeight: 1200.0, maxWidth: 1200);
      setState(() {
        file = File(object.path);
        print(file);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShowBenner(size: size),
            Text(
              'Image Event'.toUpperCase(),
              style: titleStyle,
            ),
            showImage(size),
            Text(
              'title event'.toUpperCase(),
              style: titleStyle,
            ),
            showTitle(),
            Text(
              'detail event'.toUpperCase(),
              style: titleStyle,
            ),
            showDetail(),
            Text(
              'URL message'.toUpperCase(),
              style: titleStyle,
            ),
            showHTTPS(),
            SizedBox(
              height: 20,
            ),
            showLogin(context, size),
          ],
        ),
      ),
    );
  }

  Widget showLogin(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: InkWell(
        onTap: () {
          setState(() {
            if (file == null) {
              normalDialog(context, 'กรุณาเลือกรูปภาพ');
            } else if (title == null ||
                title.isEmpty ||
                detail == null ||
                detail.isEmpty) {
              normalDialog(context, 'กรุณากรอกรายละเอียดให้ครบถ้วน');
            } else {
              setState(() {
                addEventRun();
                //readData();
              });
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
              child: Text('SAVE', style: titledoctor_style),
            ),
          ),
        ),
      ),
    );
  }

  Widget showTitle() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Container(
        height: 120,
        child: TextFormField(
          maxLines: 2,
          maxLength: 100,
          style: textStyle,
          onChanged: (value) => title = value,
          decoration: InputDecoration(
            labelText: 'หัวข้อ',
            labelStyle: titleStyle,
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
    );
  }

  Widget showDetail() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
        left: 10,
      ),
      child: Container(
        height: 120,
        child: TextFormField(
          maxLines: 4,
          maxLength: 200,
          style: textStyle,
          onChanged: (value) => detail = value,
          decoration: InputDecoration(
            labelText: 'รายละเอียด',
            labelStyle: titleStyle,
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
    );
  }

  Widget showHTTPS() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
        left: 10,
      ),
      child: Container(
        height: 60,
        child: TextFormField(
          maxLines: 1,
          maxLength: 100,
          onChanged: (value) => url = value,
          style: departmentStyle,
          decoration: InputDecoration(
            icon: Icon(Icons.http),
            // labelText: '',
            // labelStyle: titleStyle,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showImage(Size size) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          chooseImage(
            ImageSource.gallery,
          );
        },
        child: Container(
          height: size.height * 0.75,
          // width: size.width*0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(63),
              bottomLeft: Radius.circular(63),
              topRight: Radius.circular(63),
              bottomRight: Radius.circular(63),
            ),
            boxShadow: [kBoxShadow],
            image: DecorationImage(
                image: file == null
                    ? AssetImage('assets/images/gpsmap.jpg')
                    : FileImage(file),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
