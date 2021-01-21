import 'package:brhhappy/happy_countercheckin/hod/chart/chart.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class HomePage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Center(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'BRH HAPPY Vehicle'.toUpperCase(),
                  style: listtitleStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
