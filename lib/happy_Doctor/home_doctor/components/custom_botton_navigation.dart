import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/wavy_clipper.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      child: ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: size.height * 0.09,
          width: size.width,
          color: kBlueColor,
        ),
      ),
    );
  }
}
