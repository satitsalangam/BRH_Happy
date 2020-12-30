import 'package:brhhappy/happy_Run/admin_Happyrun/history/adminListHistory.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:flutter/material.dart';

class AdminRunHistory extends StatefulWidget {
  @override
  _AdminRunHistoryState createState() => _AdminRunHistoryState();
}

class _AdminRunHistoryState extends State<AdminRunHistory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShowBenner(size: size),
            AdminListHistory(),
          ],
        ),
      ),
    );
  }
}
