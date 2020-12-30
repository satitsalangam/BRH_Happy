
import 'package:brhhappy/ulility/constants.dart';
import 'package:flutter/material.dart';

import 'curve_clipper.dart';




class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        height: size.height * 0.4,
        color: kTextColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: appPadding / 2,
              vertical: appPadding * 3),
          child: Center(
            child: Image(
              width: 150,
              height: 150,
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
