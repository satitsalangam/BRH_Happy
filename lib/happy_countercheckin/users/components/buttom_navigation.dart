import 'dart:ui';

import 'package:brhhappy/happy_CounterCheckin/users/CheckIN/userCounterCheckIn.dart';
import 'package:brhhappy/happy_CounterCheckin/users/historyCheckin/userHistory.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/doctor_schedule/doctor_schedule.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/components/bottom_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CounterCheckinNavigation extends StatefulWidget {
  @override
  _CounterCheckinNavigationState createState() =>
      _CounterCheckinNavigationState();
}

class _CounterCheckinNavigationState extends State<CounterCheckinNavigation> {
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
                          builder: (context) => UserCheackIn(),
                        ),
                      )
                    : null;
              });
            },
            isSelected: bottomNavigationbarItemIndex == 0 ? true : false,
            icons: FontAwesomeIcons.mapMarkedAlt,
            text: "CheckIN",
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
                          builder: (context) => UserHistoryCheckList(),
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
