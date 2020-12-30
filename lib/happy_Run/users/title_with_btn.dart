import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          TitleWithCustom(text: title),
          Spacer(),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: kPrimaryColor,
            onPressed: press,
            child: Text(
              "More",
              style: txt_style,
            ),
          )
        ],
      ),
    );
  }
}

class TitleWithCustom extends StatelessWidget {
  const TitleWithCustom({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 24,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              text,
              style: titleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
