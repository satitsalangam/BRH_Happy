import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/single_curved_clipper.dart';
import 'package:brhhappy/user_screen%20copy.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CounterCheckINAppBar extends StatelessWidget {
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
              height: size.height * 0.12,
              width: size.width,
              color: kTextColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: appPadding * 2,
              right: appPadding * 2,
              top: appPadding * 2.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserScreen(),
                      ),
                      (route) => false);
                },
                child: Icon(
                  Icons.home,
                  color: white,
                  size: 25,
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 35,
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
