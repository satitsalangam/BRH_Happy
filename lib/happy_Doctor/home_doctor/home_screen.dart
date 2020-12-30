import 'package:brhhappy/happy_Doctor/home_doctor/components/buttom_navigation.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/components/custom_app_bar.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/components/custom_body.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/components/custom_botton_navigation.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/components/custom_status.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/components/image_doctor.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/components/profile_doctor.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatefulWidget {
  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Custombody(),
            CustomStatus(),
            //CustomAppBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:90),
                  child: ImageDoctor(),
                ),
              ],
            ),
            CustomBottomNavigationBar(),
            BottomNavigationIcons(),
          ],
        ),
      ),
    );
  }
}
