import 'dart:io';
import 'dart:math';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminReward extends StatefulWidget {
  @override
  _AdminRewardState createState() => _AdminRewardState();
}

class _AdminRewardState extends State<AdminReward> {
  File file;
  String title, details, count, score;
  bool loadStatus = true;
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

  Future<void> addReward() async {
    Random random = Random();
    int i = random.nextInt(100000000);
    String nameImage = 'reward$i.png';
    print('nameImage = $nameImage, pathImage = ${file.path}');

    Map<String, dynamic> map = Map();
    map['file'] = await MultipartFile.fromFile(file.path, filename: nameImage);
    FormData formData = FormData.fromMap(map);

    String urlImage = '${MyConstantRun().domain}saveReward.php';

    await Dio().post(urlImage, data: formData).then((value) async {
      print(title);
      print(details);
      print(count);
      print(score);
      print(nameImage);

      String url =
          '${MyConstantRun().domain}addReward.php?isAdd=true&title=$title&detail=$details&score=$score&count=$count&image=$nameImage';
      Response response = await Dio().get(url);
      if (response.toString() == 'true') {
        setState(() {
          loadStatus = false;
        });
        normalDialogSucceed(context, 'บันทึกรูปภาพสำเร็จ');
      } else {
        normalDialog(context, 'ยังอัพเดทไม่ได้กรุณาลองใหม่');
      }
    });
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
              height: 10,
            ),
            showImage(size),
            SizedBox(
              height: 20,
            ),
            showTitle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showScore(size),
                showCount(size),
              ],
            ),
            showDetail(),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: showLogin(context, size),
            ),
          ],
        ),
      ),
    );
  }

  Widget showCount(Size size) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20),
      child: Container(
        width: size.width * 0.4,
        child: Material(
          elevation: 10.0,
          color: white,
          borderRadius: BorderRadius.circular(20.0),
          child: TextField(
            style: textStyle,
            keyboardType: TextInputType.number,
            onChanged: (value) => count = value.trim(),
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(
                  vertical: appPadding * 0.4, horizontal: appPadding),
              fillColor: Colors.white,
              hintText: 'จำนวน',
              hintStyle: textStyle,
            ),
          ),
        ),
      ),
    );
  }

  Widget showScore(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Container(
        width: size.width * 0.4,
        child: Material(
          elevation: 10.0,
          color: white,
          borderRadius: BorderRadius.circular(20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            style: textStyle,
            onChanged: (value) => score = value.trim(),
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(
                  vertical: appPadding * 0.4, horizontal: appPadding),
              fillColor: Colors.white,
              hintText: 'คะแนน',
              hintStyle: textStyle,
            ),
          ),
        ),
      ),
    );
  }

  Widget showTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Material(
        elevation: 10.0,
        color: white,
        borderRadius: BorderRadius.circular(20.0),
        child: TextField(
          style: textStyle,
          onChanged: (value) => title = value.trim(),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(
                vertical: appPadding * 0.4, horizontal: appPadding),
            fillColor: Colors.white,
            hintText: 'หัวข้อ',
            hintStyle: textStyle,
            prefixIcon: Icon(
              Icons.article,
              size: 25.0,
              color: black.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }

  Widget showDetail() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Material(
        elevation: 10.0,
        color: white,
        borderRadius: BorderRadius.circular(20.0),
        child: TextField(
          maxLines: 3,
          style: textStyle,
          onChanged: (value) => details = value.trim(),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(
                vertical: appPadding * 0.4, horizontal: appPadding),
            fillColor: Colors.white,
            hintText: 'รายละเอียด',
            hintStyle: textStyle,
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
          height: size.height * 0.5,
          width: size.width * 0.7,
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

  Widget showLogin(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: InkWell(
        onTap: () {
          if (file == null) {
            normalDialog(context, 'กรุณาเลือกรูปภาพของรางวัล');
          } else if (title == null ||
              title.isEmpty ||
              details == null ||
              details.isEmpty ||
              score == null ||
              score.isEmpty ||
              count == null ||
              count.isEmpty) {
            normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
          } else {
            setState(() {
               showProcessingDiglog(context);
               addReward();
            });
           
          }
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
}
