import 'dart:convert';

import 'package:brhhappy/happy_Doctor/model/historyDoctor.dart';
import 'package:brhhappy/happy_Doctor/showBenner.dart';
import 'package:brhhappy/ulility/my_constants_happydoctor.dart';
import 'package:brhhappy/ulility/my_constants_web.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyListHistatory extends StatefulWidget {
  @override
  _MyListHistatoryState createState() => _MyListHistatoryState();
}

class _MyListHistatoryState extends State<MyListHistatory> {
  bool loadUsers = true;
  bool loadProcess = true;
  List<HistoryDoctor> historyDoctors = List();
  String score;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');

    String url =
        "${MyConstantDoctor().domain}getHistoryrating.php?select=true&id=$id";
    await Dio().get(url).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          HistoryDoctor historyDoctor = HistoryDoctor.fromJson(map);
          setState(() {
            historyDoctors.add(historyDoctor);
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
          SizedBox(
            height: size.height * 0.1,
          ),
          Container(
            height: size.height * 0.6,
            child: loadUsers ? MyStyle().showProgress() : showNoContent(),
          ),
        ],
      ),
    );
  }

  Widget showContent(Size size) {
    return Swiper(
      itemCount: historyDoctors.length,
      itemWidth: size.width - 2 * 64,
      layout: SwiperLayout.STACK,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
            activeSize: 12,
            space: 4,
            activeColor: Colors.pink,
            color: Colors.blueGrey[50]),
      ),
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top: 32, bottom: 10, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Text(
                            '${historyDoctors[index].drForename} ${historyDoctors[index].drSurname}',
                            style: menuTextStyle,
                            // textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Text(
                          '${historyDoctors[index].drrComment}',
                          style: departmentStyle,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating:
                                  double.parse(historyDoctors[index].drrScore),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                '${historyDoctors[index].drrDatetime}',
                                style: smallStyle,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 75,
                  child: CircleAvatar(
                    radius: 72,
                    backgroundImage: NetworkImage(
                        '${MyConstantWeb().domain}GoodDoctor/${historyDoctors[index].drImg}'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
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
                  'ยังไม่มีรายการประเมินของวันนี้',
                  style: textStyle,
                ),
              ),
            ]),
          );
  }
}
