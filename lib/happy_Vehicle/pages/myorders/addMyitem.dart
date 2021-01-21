import 'dart:io';

import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MyAdditemVehicle extends StatefulWidget {
  @override
  _MyAdditemVehicleState createState() => _MyAdditemVehicleState();
}

class _MyAdditemVehicleState extends State<MyAdditemVehicle> {
  File file;
  Future<void> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker()
          .getImage(source: source, maxHeight: 500.0, maxWidth: 500);
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'เพิ่มข้อมูลอุปกรณ์'.toUpperCase(),
          style: listtitleStyle,
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(
        //         Icons.notifications,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {})
        // ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(
            FontAwesomeIcons.tags,
            size: 25,
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => VehicleUserAddItem(),
            //   ),
            // );
          }),
      bottomNavigationBar: BottomAppBar(
        color: blueGrey,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
          child: Row(children: <Widget>[]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            showImage(size),
            Container(
              width: size.width * 0.9,
              child: TextFormField(
                style: inputStyle,
                decoration: InputDecoration(
                    helperText: 'Input name'.toUpperCase(),
                    helperStyle: datetimetStyle),
              ),
            ),
            Container(
              width: size.width * 0.9,
              child: TextFormField(
                style: inputStyle,
                decoration: InputDecoration(
                    helperText: 'Input brand'.toUpperCase(),
                    helperStyle: datetimetStyle),
              ),
            ),
            Container(
              width: size.width * 0.9,
              child: TextFormField(
                style: inputStyle,
                decoration: InputDecoration(
                    helperText: 'Input Type'.toUpperCase(),
                    helperStyle: datetimetStyle),
              ),
            ),
            Container(
              width: size.width * 0.9,
              child: TextFormField(
                style: inputStyle,
                decoration: InputDecoration(
                    helperText: 'Input location'.toUpperCase(),
                    helperStyle: datetimetStyle),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: size.width * 0.4,
                  child: TextFormField(
                    style: inputStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'จำนวน',
                        hintStyle: datetimetStyle,
                        helperText: 'Input Count'.toUpperCase(),
                        helperStyle: datetimetStyle),
                  ),
                ),
                Container(
                  width: size.width * 0.4,
                  child: TextFormField(
                    style: inputStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'น้ำหนัก',
                        hintStyle: datetimetStyle,
                        helperText: 'Input Width'.toUpperCase(),
                        suffixText: 'กิโลกรัม',
                        suffixStyle: departmentStyle,
                        helperStyle: datetimetStyle),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: size.width * 0.4,
                  child: TextFormField(
                    style: inputStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'ยาว',
                        hintStyle: datetimetStyle,
                        helperText: 'Input Length'.toUpperCase(),
                        suffixText: 'เมตร',
                        suffixStyle: departmentStyle,
                        helperStyle: datetimetStyle),
                  ),
                ),
                Container(
                  width: size.width * 0.4,
                  child: TextFormField(
                    style: inputStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'กว้าง',
                        hintStyle: datetimetStyle,
                        helperText: 'Input Height'.toUpperCase(),
                        suffixText: 'เมตร',
                        suffixStyle: departmentStyle,
                        helperStyle: datetimetStyle),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
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
          height: size.height * 0.2,
          width: size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(43),
              bottomLeft: Radius.circular(43),
              topRight: Radius.circular(43),
              bottomRight: Radius.circular(43),
            ),
            boxShadow: [kBoxShadow],
            image: DecorationImage(
                image: file == null
                    ? AssetImage('assets/images/image.png')
                    : FileImage(file),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
