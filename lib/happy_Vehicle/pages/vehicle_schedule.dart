import 'dart:convert';

import 'package:brhhappy/happy_Vehicle/models/vehicleSchedulemodel.dart';
import 'package:brhhappy/ulility/my_constants_vehicle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:bubble_timeline/bubble_timeline.dart';
import 'package:bubble_timeline/timeline_item.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class VehicleSchedule extends StatefulWidget with NavigationStates {
  @override
  _VehicleScheduleState createState() => _VehicleScheduleState();
}

class _VehicleScheduleState extends State<VehicleSchedule> {
  VehicleSchedulemodel vehicleSchedulemodel;
  bool loadStatus = true;
  String image,
      sunStart,
      sunEnd,
      monStart,
      monEnd,
      tuesStart,
      tuesEnd,
      wedStart,
      wedEnd,
      thursStart,
      thursEnd,
      friStart,
      friEnd,
      satStart,
      satEnd;
  @override
  void initState() {
    super.initState();
    readSchedule();
  }

  Future<void> readSchedule() async {
    String url = "${MyConstantVehicle().domain}getSchedule.php?select=true";
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            vehicleSchedulemodel = VehicleSchedulemodel.fromJson(map);
            sunStart = vehicleSchedulemodel.vsdSundayStart;
            sunEnd = vehicleSchedulemodel.vsdSundayFinish;
            monStart = vehicleSchedulemodel.vsdMondayStart;
            monEnd = vehicleSchedulemodel.vsdMondayFinish;
            tuesStart = vehicleSchedulemodel.vsdTuesdayStart;
            tuesEnd = vehicleSchedulemodel.vsdTuesdayFinish;
            wedStart = vehicleSchedulemodel.vsdWednesdayStart;
            wedEnd = vehicleSchedulemodel.vsdWednesdayFinish;
            thursStart = vehicleSchedulemodel.vsdTuesdayStart;
            thursEnd = vehicleSchedulemodel.vsdThursdayFinish;
            friStart = vehicleSchedulemodel.vsdFridayStart;
            friEnd = vehicleSchedulemodel.vsdFridayFinish;
            satStart = vehicleSchedulemodel.vsdSaturdayStart;
            satEnd = vehicleSchedulemodel.vsdSaturdayFinish;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Text(
                      'BRH HAPPY Vehicle'.toUpperCase(),
                      style: listtitleStyle,
                    ),
                  ),
                ),
                BubbleTimeline(
                  bubbleDiameter: 60,
                  items: [
                    // TimelineItem(
                    //   title: 'SunDay',
                    //   subtitle: sunStart == null || sunStart == null
                    //       ? 'No Schedule'
                    //       : '$sunStart - $sunEnd',
                    //   child: Icon(
                    //     Icons.date_range,
                    //     color: Colors.white,
                    //   ),
                    //   bubbleColor: Colors.red,
                    // ),
                    TimelineItem(
                      title: 'Monday',
                      subtitle: monStart == null || monEnd == null
                          ? 'No Schedule'
                          : '$monStart - $monEnd',
                      child: Icon(
                        FontAwesomeIcons.shippingFast,
                        color: Colors.white,
                        size: 20,
                      ),
                      bubbleColor: Colors.yellow,
                    ),
                    TimelineItem(
                      title: 'Tuesday',
                      subtitle: tuesStart == null || tuesEnd == null
                          ? 'No Schedule'
                          : '$tuesStart - $tuesEnd',
                      child: Icon(
                        FontAwesomeIcons.shippingFast,
                        color: Colors.white,
                        size: 20,
                      ),
                      bubbleColor: Colors.pink,
                    ),
                    TimelineItem(
                      title: 'Wednesday',
                      subtitle: wedStart == null || wedEnd == null
                          ? 'No Schedule'
                          : '$wedStart - $wedEnd',
                      child: Icon(
                        FontAwesomeIcons.shippingFast,
                        color: Colors.white,
                        size: 20,
                      ),
                      bubbleColor: Colors.green,
                    ),
                    TimelineItem(
                      title: 'Thursday',
                      subtitle: thursStart == null || thursEnd == null
                          ? 'No Schedule'
                          : '$thursStart - $thursEnd',
                      child: Icon(
                        FontAwesomeIcons.shippingFast,
                        color: Colors.white,
                        size: 20,
                      ),
                      bubbleColor: Colors.orange,
                    ),
                    TimelineItem(
                      title: 'Friday',
                      subtitle: friStart == null || friEnd == null
                          ? 'No Schedule'
                          : '$friStart - $friEnd',
                      child: Icon(
                        FontAwesomeIcons.shippingFast,
                        color: Colors.white,
                        size: 20,
                      ),
                      bubbleColor: Colors.lightBlue,
                    ),
                    // TimelineItem(
                    //   title: 'Saturday',
                    //   subtitle: satStart == null || satStart == null
                    //       ? 'No Schedule
                    //       : '$satStart - $satEnd',
                    //   child: Icon(
                    //     Icons.date_range,
                    //     color: Colors.white,
                    //   ),
                    //   bubbleColor: Colors.purple,
                    // ),
                  ],
                  stripColor: Colors.teal,
                  scaffoldColor: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
