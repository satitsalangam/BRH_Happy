import 'package:brhhappy/happy_Run/users/bmi/widget_utils.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'input_page/input_page_styles.dart';

class BmiAppBar extends StatelessWidget {
  final bool isInputPage;
  static const String wavingHandEmoji = "\uD83D\uDC4B";
  static const String whiteSkinTone = "\uD83C\uDFFB";

  const BmiAppBar({Key key, this.isInputPage = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.0,
      child: Container(
        height: appBarHeight(context),
        color: kTextColor,
        child: Padding(
          padding: EdgeInsets.all(screenAwareSize(16.0, context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildLabel(context),
              _buildIcon(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: screenAwareSize(11.0, context)),
        child: IconButton(
          onPressed: () {},
          iconSize: 45,
          icon: Image.asset('assets/images/logo.png'),
        ));
  }

  RichText _buildLabel(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 20.0),
        children: [
          TextSpan(
            text: isInputPage ? "วัดดัชนีมวลกาย " : "ดัชนีมวลกายของคุณ",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          // TextSpan(text: isInputPage ? getEmoji(context) : ""),
        ],
      ),
    );
  }

  // https://github.com/flutter/flutter/issues/9652
  String getEmoji(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? wavingHandEmoji
        : wavingHandEmoji + whiteSkinTone;
  }
}
