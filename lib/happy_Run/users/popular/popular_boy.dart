import 'dart:convert';

import 'package:brhhappy/happy_Run/model/popular_run.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PopularBoy extends StatefulWidget {
  @override
  _PopularBoyState createState() => _PopularBoyState();
}

class _PopularBoyState extends State<PopularBoy> {
  List<RunPopular> popular = List();
  bool loadStatus = true;
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    if (popular.length != 0) {
      popular.clear();
    }
    String url = '${MyConstantRun().domain}getPopularMan.php?select=true';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          RunPopular popularrun = RunPopular.fromJson(map);
          setState(() {
            popular.add(popularrun);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Container(
            // color: Colors.red.withOpacity(0.5),
            height: size.height * 0.35,
            child: loadStatus ? MyStyle().showProgress() : showContent(size),
          ),
        ),
      ],
    );
  }

  Widget showContent(Size size) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: popular.length,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                margin: EdgeInsets.only(top: 0, bottom: 0),
                width: size.width * 0.4,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: white,
                    boxShadow: [kBoxShadow]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 60),
                      child: Text(
                        "${popular[index].empPnamefullTh}",
                        // style.name,
                        style: textStyle,
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${index + 1}',
                          style: popularnumberStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.run_circle,
                                    color: secondary.withOpacity(0.8),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text(
                                    "${popular[index].distance} กม.",
                                    // style.time.toString() + 'min',
                                    style: smallStyle,
                                  )
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.33,
                                child: Text(
                                  '${popular[index].empDeptdesc}',
                                  style: smallStyle,
                                  overflow: TextOverflow.clip,
                                  softWrap: false,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Positioned(
                right: 10,
                top: 50,
                child: CircleAvatar(
                  radius: 32,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: popular[index].empImg == null
                        ? AssetImage('assets/images/avatarMan.png')
                        : NetworkImage(
                            '${MyConstantRun().domain}ImagesProfile/${popular[index].empImg}'),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
