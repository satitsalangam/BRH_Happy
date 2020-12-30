import 'dart:ui';
import 'package:brhhappy/happy_Doctor/home_doctor/cameraProfiel.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/doctor_history/doctorHistory.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/doctor_schedule/doctor_schedule.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/components/bottom_icon.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/list_histatory.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationIcons extends StatefulWidget {
  @override
  _BottomNavigationIconsState createState() => _BottomNavigationIconsState();
}

class _BottomNavigationIconsState extends State<BottomNavigationIcons> {
  // setting it to 1 so on starting the app it will select center icon
  int bottomNavigationbarItemIndex = 3;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      left: size.width * 0.1,
      right: size.width * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomIcons(
            onPressed: () {
              setState(() {
                bottomNavigationbarItemIndex = 0;
                bottomNavigationbarItemIndex == 0
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyListHistatory(),
                        ),
                      )
                    : null;
              });
            },
            isSelected: bottomNavigationbarItemIndex == 0 ? true : false,
            icons: FontAwesomeIcons.chartBar,
            text: "To day",
          ),
          BottomIcons(
            onPressed: () {
              setState(() {
                bottomNavigationbarItemIndex = 1;
                bottomNavigationbarItemIndex == 1
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyDoctorSchedule(),
                        ),
                      )
                    : null;
              });
            },
            isSelected: bottomNavigationbarItemIndex == 1 ? true : false,
            icons: FontAwesomeIcons.calendarAlt,
            text: "Calendar",
          ),
          BottomIcons(
            onPressed: () {
              setState(() {
                bottomNavigationbarItemIndex = 2;
                bottomNavigationbarItemIndex == 2
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyDoctorHistory(),
                        ),
                      )
                    : null;
              });
            },
            isSelected: bottomNavigationbarItemIndex == 2 ? true : false,
            icons: FontAwesomeIcons.envelopeOpenText,
            text: "History",
          ),
        ],
      ),
    );
  }
}
