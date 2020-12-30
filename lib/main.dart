import 'package:brhhappy/login/login_screen.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: kTextColor),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: kTextColor,
        // backgroundColor: Colors.black,
      ),
      title: 'BRH Happy',
      
     // home: MyProfileDoctor(),
      home: LoginScreen(),
      //home: UserListMessage(),
      // home: DoctorHomeScreen(),
      //home: ListData(),
      //home: RankingScreen(),
      //home: SwiperRunner(),
      //home: MyUserPhotoProfile(),
      // home: CameraProfile(),
    );
  }
}
