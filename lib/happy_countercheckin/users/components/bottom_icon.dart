import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';

class BottomIcons extends StatefulWidget {
  final Function onPressed;
  final bool isSelected;
  final String text;
  final IconData icons;

  BottomIcons({
    @required this.onPressed,
    @required this.isSelected,
    @required this.icons,
    @required this.text,
  });

  @override
  _BottomIconsState createState() => _BottomIconsState();
}

class _BottomIconsState extends State<BottomIcons> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: widget.onPressed,
        child: widget.isSelected == true
            ? Column(
                children: [
                  Container(
                    width: size.width * 0.15,
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: darkGreen, width: 4),
                      color: white,
                    ),
                    child: Icon(
                      widget.icons,
                      color: black,
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Text(widget.text, style: textStyle),
                  SizedBox(
                    height: size.height * 0.03,
                  )
                ],
              )
            : Column(
                children: [
                  Container(
                    width: size.width * 0.15,
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkGreen,
                    ),
                    child: Icon(
                      widget.icons,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: white.withOpacity(0.4),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  )
                ],
              ));
  }
}
