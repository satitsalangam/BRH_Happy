import 'dart:convert';

import 'package:brhhappy/happy_Doctor/model/userProfile.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:bubble_timeline/bubble_timeline.dart';
import 'package:bubble_timeline/timeline_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDoctorSchedule extends StatefulWidget {
  @override
  _MyDoctorScheduleState createState() => _MyDoctorScheduleState();
}

class _MyDoctorScheduleState extends State<MyDoctorSchedule> {
  bool loadUsers = true;
  UserProfileDoctor userProfileDoctor;
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
    readData();
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String loactionid = preferences.getString('loaction');
    print('loaction>>>>$loactionid');
    String url =
        "${MyConstantDoctor().domain}getProfileDoctor.php?select=true&id=$id&locationid=$loactionid";
    await Dio().get(url).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            userProfileDoctor = UserProfileDoctor.fromJson(map);
            image = userProfileDoctor.drImg;
            sunStart = userProfileDoctor.dsSundayStart;
            sunEnd = userProfileDoctor.dsSundayFinish;
            monStart = userProfileDoctor.dsMondayStart;
            monEnd = userProfileDoctor.dsMondayFinish;
            tuesStart = userProfileDoctor.dsTuesdayStart;
            tuesEnd = userProfileDoctor.dsTuesdayFinish;
            wedStart = userProfileDoctor.dsWednesdayStart;
            wedEnd = userProfileDoctor.dsWednesdayFinish;
            thursStart = userProfileDoctor.dsThursdayStart;
            thursEnd = userProfileDoctor.dsThursdayFinish;
            friStart = userProfileDoctor.dsFridayStart;
            friEnd = userProfileDoctor.dsFridayFinish;
            satStart = userProfileDoctor.dsSaturdayStart;
            satEnd = userProfileDoctor.dsSaturdayFinish;
          });
          print('image>>$image');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'schedule'.toUpperCase(),
              style: menuStyle,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Icon(
             FontAwesomeIcons.calendarWeek,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              BubbleTimeline(
                bubbleDiameter: 60,
                items: [
                  TimelineItem(
                    title: 'SunDay',
                    subtitle: sunStart == null || sunStart == null
                        ? 'No Schedule'
                        : '$sunStart - $sunEnd',
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    bubbleColor: Colors.red,
                  ),
                  TimelineItem(
                    title: 'Monday',
                    subtitle: monStart == null || monEnd == null
                        ? 'No Schedule'
                        : '$monStart - $monEnd',
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    bubbleColor: Colors.yellow,
                  ),
                  TimelineItem(
                    title: 'Tuesday',
                    subtitle: tuesStart == null || tuesEnd == null
                        ? 'No Schedule'
                        : '$tuesStart - $tuesEnd',
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    bubbleColor: Colors.pink,
                  ),
                  TimelineItem(
                    title: 'Wednesday',
                    subtitle: wedStart == null || wedEnd == null
                        ? 'No Schedule'
                        : '$wedStart - $wedEnd',
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    bubbleColor: Colors.green,
                  ),
                  TimelineItem(
                    title: 'Thursday',
                    subtitle: thursStart == null || thursEnd == null
                        ? 'No Schedule'
                        : '$thursStart - $thursEnd',
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    bubbleColor: Colors.orange,
                  ),
                  TimelineItem(
                    title: 'Friday',
                    subtitle: friStart == null || friEnd == null
                        ? 'No Schedule'
                        : '$friStart - $friEnd',
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    bubbleColor: Colors.lightBlue,
                  ),
                  TimelineItem(
                    title: 'Saturday',
                    subtitle: satStart == null || satStart == null
                        ? 'No Schedule'
                        : '$satStart - $satEnd',
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    bubbleColor: Colors.purple,
                  ),
                ],
                stripColor: Colors.teal,
                scaffoldColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
