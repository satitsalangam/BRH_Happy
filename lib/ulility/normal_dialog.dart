
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'loadpage.dart';


Future<void> normalDialog(BuildContext context, String title) async {
  Alert(
    context: context,
    type: AlertType.warning,
    title: title,
    style: AlertStyle(titleStyle: textStyle),
    buttons: [
      DialogButton(
        child: Text(
          "ตกลง",
          style: loginTextStyle,
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}

Future<void> normalDialogSucceed(BuildContext context, String title) async {
  Alert(
    context: context,
    type: AlertType.success,
    title: title,
    style: AlertStyle(titleStyle: loginStyle),
    buttons: [
      DialogButton(
        child: Text(
          "ตกลง",
          style: loginTextStyle,
        ),
        onPressed: () {
          // Navigator.pop(context);
          showProcessingDiglog(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoadPage()));
        },
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}

Future<void> showProcessingDiglog(BuildContext context) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
              width: 250.0,
              height: 100.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Processing...',
                        style: GoogleFonts.orbitron(color: Color(0xFF0878F0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
