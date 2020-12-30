import 'package:flutter/material.dart';

class MyStyle {
  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
  MyStyle();
}
