import 'package:brhhappy/doctor_screen.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/single_curved_clipper.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomStatus extends StatefulWidget {
  @override
  _CustomStatusState createState() => _CustomStatusState();
}

class _CustomStatusState extends State<CustomStatus> {
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // rotating the appbar because we can use same clipper in next screen
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(math.pi),
          child: ClipPath(
            clipper: SingleCurvedClipper(),
            child: Container(
              height: size.height * 0.15,
              width: size.width,
              color: kTextColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: appPadding * 0.5, right: appPadding * 2, top: appPadding * 2.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    iconSize: 50,
                    icon: Image.asset('assets/images/logo.png'),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorScreen(),
                      ),
                      (route) => false);
                },
                child: Icon(
                  FontAwesomeIcons.home,
                  color: white,
                  size: 25,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
