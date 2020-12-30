import 'dart:convert';

import 'package:brhhappy/happy_Doctor/model/doctorRatting.dart';
import 'package:brhhappy/happy_Doctor/showBenner.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDoctorHistory extends StatefulWidget {
  @override
  _MyDoctorHistoryState createState() => _MyDoctorHistoryState();
}

class _MyDoctorHistoryState extends State<MyDoctorHistory> {
  bool loadUsers = true;
  bool loadProcess = true;
  List<DoctorRatting> doctorRattings = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      readData();
    });
    return null;
  }

  Future<void> readData() async {
    if (doctorRattings.length != 0) {
      doctorRattings.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String url =
        "${MyConstantDoctor().domain}getHistory.php?select=true&id=$id";
    await Dio().get(url).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          DoctorRatting doctorRatting = DoctorRatting.fromJson(map);
          setState(() {
            doctorRattings.add(doctorRatting);
          });
        }
      } else {
        setState(() {
          loadProcess = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * 0.2,
            child: ShowBennerDoctor(size: size),
          ),
          loadUsers ? MyStyle().showProgress() : showNoContent(),
        ],
      ),
    );
  }

  Widget showContent(Size size) {
    return Container(
      height: size.height * 0.8,
      child: RefreshIndicator(
        onRefresh: refreshList,
        child: ListView.builder(
          itemCount: doctorRattings.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
              child: Container(
                decoration: BoxDecoration(boxShadow: [kBoxShadow]),
                // height: size.height * 0.15,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            '${doctorRattings[index].drForename} ${doctorRattings[index].drSurname}',
                            style: textStyle,
                          ),
                        ),
                        Text(
                          '${doctorRattings[index].dlName}',
                          style: textStyle,
                        ),
                        Row(
                          children: [
                            Container(
                              child: RatingBarIndicator(
                                rating: double.parse(
                                    '${doctorRattings[index].drrScore}'),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4),
                                direction: Axis.horizontal,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            '${doctorRattings[index].drrComment}',
                            style: smallStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                '${doctorRattings[index].drrDatetime}',
                                style: smallStyle,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget showNoContent() {
    Size size = MediaQuery.of(context).size;
    return loadProcess
        ? showContent(size)
        : Container(
            child: Column(children: [
              SizedBox(
                height: 200,
              ),
              Center(
                child: Text(
                  'ยังไม่มีรายการประวัติการประเมิน',
                  style: textStyle,
                ),
              ),
            ]),
          );
  }
}
