import 'package:brhhappy/admin_screen.dart';
import 'package:brhhappy/user_screen%20copy.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadPage extends StatefulWidget {
  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  @override
  void initState() {
    super.initState();
    usercheckLogin();
  }

    Future<void> usercheckLogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString('usertype');
      String adminType = preferences.getString('admintype');
      // String adminchoseType = preferences.getString('admintype');
      print('uerstype>>>>>>>$chooseType');
      print('admintype>>>>>>>$adminType');

      if (chooseType != null || adminType != null) {
        if (chooseType.toString() == 'employee' ||
            chooseType.toString() == 'hod') {
          // showProcessingDiglog(context);
          print(chooseType);
          routoService(UserScreen());
        } else if (adminType.toString() == 'admin') {
          routoService(AdminScreen());
          print('testadmin');
        } else {
          print('adsadsadasd');
        }
      }
    } catch (e) {}
  }


  void routoService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GradientAppBar(
      //   backgroundColorStart: Color(0xFF5348E0),
      //   backgroundColorEnd: Color(0xFF0ED8F3),
      //   elevation: 0,
      // ),
      body: Form(
          child: Container(
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF5348E0), Color(0xFF0ED8F3)]),
        ),
      )),
    );
  }
}
