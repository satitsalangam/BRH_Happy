import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';

class ShowBennerCounterCheckIN extends StatelessWidget {
  const ShowBennerCounterCheckIN({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.15,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 20, left: 20, bottom: 0),
            height: size.height * 0.2 - 10,
            decoration: BoxDecoration(
              color: kTextColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Center(
              child: Text(
                'counter check in'.toUpperCase(),
                style: headTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
