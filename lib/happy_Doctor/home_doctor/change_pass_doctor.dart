import 'package:brhhappy/happy_Doctor/showBenner.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/process_SingOut.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordDoctor extends StatefulWidget {
  @override
  _ChangePasswordDoctorState createState() => _ChangePasswordDoctorState();
}

class _ChangePasswordDoctorState extends State<ChangePasswordDoctor> {
  bool loadProcess = true; //Add Process
  String password, passwordNew, passwordConfrim, id;

  Future<void> chackPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String doctorid = preferences.getString('id');
    print('id>>>$doctorid');
    print('password>>>$password');

    String urlSelect =
        '${MyConstantDoctor().domain}getChangePasswordID.php?select=true&password=$password&id=$doctorid';
    try {
      Response response = await Dio().get(urlSelect);
      if (response.toString() != 'null') {
        chackConfrim();
      } else {
        normalDialog(context, 'รหัสผ่านเก่าไม่ถูกต้องกรุณาลองใหม่');
      }
    } catch (e) {}
  }

  Future<void> chackConfrim() async {
    if (passwordNew == passwordConfrim) {
      setState(() {
        loadProcess ? showProcessingDiglog(context) : MyStyle().showProgress();
        changePassword();
      });
    } else {
      normalDialog(
          context, 'รหัสผ่านใหม่ไม่ตรงกัน \nกรุณากรองข้อมูลใหม่อีกครั้ง');
    }
  }

  Future<void> changePassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String doctorid = preferences.get('id');
    print('empid>>>>>>>>$doctorid');
    print('passwordNew>>>>>>>>$passwordNew');
    String urlUpdate =
        '${MyConstantDoctor().domain}updatePassword.php?isupdate=true&passwordNew=$passwordNew&empid=$doctorid';
    try {
      Response response = await Dio().get(urlUpdate);
      if (response.toString() == 'true') {
        setState(() {
          loadProcess = false;
          processSignOut(context);
        });
      } else {
        normalDialog(context, 'ระบบเกิดข้อผิดพลาด ลองใหม่อีกครั้ง');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: size.height * 0.2,
                    child: ShowBennerDoctor(size: size)),
                showPasswordOld(context),
                showPasswordNew(context),
                showPasswordConfrim(context),
                // Spacer(),
                btnForm(),
              ],
            )
          ],
        ),
      ),
     
    );
  }

  Widget showPasswordOld(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(
            Size(MediaQuery.of(context).size.width * 1, 50.0),
          ),
          child: TextFormField(
            obscureText: true,
            onChanged: (value) => password = value.trim(),
            style: loginTextStyle,
            decoration: InputDecoration(
              labelText: 'รหัสผ่านเข้าระบบเก่า',
              labelStyle: loginTextStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showPasswordNew(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(
            Size(MediaQuery.of(context).size.width * 1, 50.0),
          ),
          child: TextFormField(
            obscureText: true,
            onChanged: (value) => passwordNew = value.trim(),
            style: loginTextStyle,
            decoration: InputDecoration(
              labelText: 'รหัสผ่านเข้าระบบใหม่',
              labelStyle: loginTextStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showPasswordConfrim(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(
            Size(MediaQuery.of(context).size.width * 1, 50.0),
          ),
          child: TextFormField(
            obscureText: true,
            onChanged: (value) => passwordConfrim = value.trim(),
            style: loginTextStyle,
            decoration: InputDecoration(
              labelText: 'ยืนยันรหัสผ่านเข้าระบบใหม่',
              labelStyle: loginTextStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
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
            if (password == null ||
                password.isEmpty ||
                passwordNew == null ||
                passwordNew.isEmpty ||
                passwordConfrim == null ||
                passwordConfrim.isEmpty) {
              normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
            } else {
              chackPassword();
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          padding: EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0CD2F5), Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ), 
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: 1200.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: Text("ChangePassword",
                  textAlign: TextAlign.center, style: listtitleStyle),
            ),
          ),
        ),
      ),
    );
  }
}
