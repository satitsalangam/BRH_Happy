
import 'package:brhhappy/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> processSignOut(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear().then((value) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => LoginScreen(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  });
}
