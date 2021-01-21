
import 'package:brhhappy/login/login_screen.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:flutter/material.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.black, statusBarBrightness: Brightness.light));
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: kTextColor,
        // accentColor: Colors.red
        //backgroundColor: Colors.black,
      ),
      //title: 'BRH Happy',
      //home: TrackOrderPage(),
      //home: MyTests(),
      home: LoginScreen(),
    );
  }
}
