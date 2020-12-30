import 'dart:convert';

import 'package:brhhappy/happy_Run/model/message_run.dart';
import 'package:brhhappy/happy_Run/users/event/viewEvent.dart';

import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';

import 'package:brhhappy/ulility/text_style.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class UserListEvent extends StatefulWidget {
  @override
  _UserListEventState createState() => _UserListEventState();
}

class _UserListEventState extends State<UserListEvent> {
  List<Messagerun> messageruns = [];
  bool loadImage = true;
  bool isChecked = true;
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    if (messageruns.length != 0) {
      messageruns.clear();
    }
    String url = '${MyConstantRun().domain}getListEvent.php?select=true';
    await Dio().get(url).then((value) {
      setState(() {
        loadImage = false;
      });
      if (value.toString() != null) {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          Messagerun messagerun = Messagerun.fromJson(map);
          setState(() {
            messageruns.add(messagerun);
          });
        }
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          // color: Colors.red,
          height: size.height * 0.55,
          child: Swiper(
            viewportFraction: 0.8,
            scale: 0.9,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  activeSize: 12,
                  space: 4,
                  activeColor: Colors.pink,
                  color: blueGrey),
            ),
            itemCount: messageruns.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  height: size.height * 0.25,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [kBoxShadow]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: size.width * 1,
                          height: size.height * 0.3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            child: Image(
                              image: NetworkImage(
                                  "${MyConstantRun().domain}event/${messageruns[index].runMeimage}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                                width: size.width * 0.68,
                                child: Text(
                                  '${messageruns[index].runMetitle}',
                                  style: textStyle,
                                  overflow: TextOverflow.clip,
                                )),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            RaisedButton.icon(
                              color: Color(0xFF162A49),
                              icon: Icon(Icons.search),
                              label: Text('view'),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewEventRun(
                                          messagerun: messageruns[index]),
                                    ));
                              },
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: Text(
                                '${messageruns[index].runMecreatedate}',
                                style: smallStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
