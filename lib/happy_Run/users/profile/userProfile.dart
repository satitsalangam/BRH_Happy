import 'package:brhhappy/happy_Run/model/userModel.dart';
import 'package:brhhappy/happy_Run/users/cameraProfiel.dart';
import 'package:brhhappy/happy_Run/users/profile/histatoryHealth.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyUserProfile extends StatefulWidget {
  final Usermodel usermodel;
  MyUserProfile({Key key, this.usermodel}) : super(key: key);
  @override
  _MyUserProfileState createState() => _MyUserProfileState();
}

class _MyUserProfileState extends State<MyUserProfile> {
  Usermodel usermodels;
  String image,
      pname,
      fname,
      empid,
      empdept,
      engPname,
      engLname,
      engFname,
      empdeptID,
      empposdes,
      bmi,
      fix;

  @override
  void initState() {
    super.initState();
    usermodels = widget.usermodel;
    image = usermodels.empImg;
    print('image>>>$image');
    pname = usermodels.empPnameTh;
    fname = usermodels.empPnamefullTh;
    empid = usermodels.empId;
    engPname = usermodels.empPname;
    engFname = usermodels.empFname;
    engLname = usermodels.empLname;
    empdept = usermodels.empDeptdesc;
    empdeptID = usermodels.empDeptid;
    empposdes = usermodels.empPosdesc;
  }

  Future<void> addHealth() async {
    // print(empid);
    // print(bmi);
    // print(fix);

    String url =
        '${MyConstantRun().domain}addHealth.php?isAdd=true&empid=$empid&bmi=$bmi&fix=$fix';
    Response response = await Dio().get(url).then((value) {
      setState(() {
        Navigator.pop(context);
      });
    });
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShowBenner(size: size),
            Container(
              width: 110,
              height: 110,
              child: Stack(
                fit: StackFit.expand,
                // overflow: Overflow.visible,
                children: [
                  CircleAvatar(
                    // radius: 35,
                    child: CircleAvatar(
                      radius: 52,
                      backgroundImage: image != null
                          ? NetworkImage(
                              "${MyConstantRun().domain}ImagesProfile/$image")
                          : pname == 'นาย'
                              ? AssetImage('assets/images/avatarMan.png')
                              : AssetImage('assets/images/avatarWomen.png'),
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
                                builder: (context) => CameraProfile(),
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
              ),
            ),          
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'รหัสพนักงาน',
                        style: listtitleStyle,
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: Icon(
                            Icons.history_edu_outlined,
                            size: 35,
                            color: kTextColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistatoryHealth(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$empid',
                    style: textStyle,
                  ),
                  Text(
                    'ชื่อ',
                    style: listtitleStyle,
                  ),
                  Text(
                    '$pname  $fname',
                    style: textStyle,
                  ),
                  Text(
                    'Name',
                    style: listtitleStyle,
                  ),
                  Text(
                    '$engPname $engFname $engLname',
                    style: textStyle,
                  ),
                  Text(
                    'ตำแหน่ง',
                    style: listtitleStyle,
                  ),
                  Text(
                    '$empposdes',
                    style: textStyle,
                  ),
                  Text(
                    'รหัสแผนก',
                    style: listtitleStyle,
                  ),
                  Text(
                    '$empdeptID',
                    style: textStyle,
                  ),
                  Text(
                    'แผนก',
                    style: listtitleStyle,
                  ),
                  Text(
                    '$empdept',
                    style: textStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'วัดดัชณีมวลกาย : ',
                        style: listtitleStyle,
                      ),
                      showBMI(size)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'วัดเปอเซ็นต์ FIX : ',
                        style: listtitleStyle,
                      ),
                      showFIX(size)
                    ],
                  ),
                ],
              ),
            ),
            showUpload(context, size),
          ],
        ),
      ),
    );
  }

  Widget showFIX(Size size) {
    return Container(
      width: size.width * 0.4,
      height: 40,
      child: Material(
        elevation: 10.0,
        color: white,
        borderRadius: BorderRadius.circular(20.0),
        child: TextField(
          keyboardType: TextInputType.number,
          style: textStyle,
          onChanged: (value) => fix = value.trim(),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(
                vertical: appPadding * 0.4, horizontal: appPadding),
            fillColor: Colors.white,
            hintText: 'FIX',
            hintStyle: textStyle,
          ),
        ),
      ),
    );
  }

  Widget showBMI(Size size) {
    return Container(
      width: size.width * 0.4,
      height: 40,
      child: Material(
        elevation: 10.0,
        color: white,
        borderRadius: BorderRadius.circular(20.0),
        child: TextField(
          keyboardType: TextInputType.number,
          style: textStyle,
          onChanged: (value) => bmi = value.trim(),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(
                vertical: appPadding * 0.4, horizontal: appPadding),
            fillColor: Colors.white,
            hintText: 'BMI',
            hintStyle: textStyle,
          ),
        ),
      ),
    );
  }

  Widget showUpload(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
      child: InkWell(
        onTap: () {
          if (bmi == null || bmi.isEmpty || fix == null || fix.isEmpty) {
            normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
          } else {
            addHealth();
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
