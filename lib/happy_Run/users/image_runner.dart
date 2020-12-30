import 'dart:convert';

import 'package:brhhappy/happy_Run/model/listImage.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShowImageList extends StatefulWidget {
  @override
  _ShowImageListState createState() => _ShowImageListState();
}

class _ShowImageListState extends State<ShowImageList> {
  List<ListImage> listImages = List();
  bool loadStatus = true;
  String fullname, distance, department;
  @override
  void initState() {
    super.initState();
    readListImage();
  }

  Future<void> readListImage() async {
    String url = '${MyConstantRun().domain}getListRun.php?select=true';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          ListImage listImage = ListImage.fromJson(map);
          print(result);
          setState(() {
            listImages.add(listImage);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.57,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: listImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 20 * 2.5),
            width: size.width * 0.5,
            // height: size.height*0.5,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.4,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white, boxShadow: [kBoxShadow]),
                  child: Image.network(
                    '${MyConstantRun().domain}image/${listImages[index].imImage}',
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Colors.white,
                        boxShadow: [kBoxShadow]),
                    child: Row(
                      children: [
                        Container(
                          width: size.width * 0.35,
                          child: RichText(
                            overflow: TextOverflow.clip,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "${listImages[index].empPnamefullTh}\n"
                                    .toUpperCase(),
                                style: datetimetStyle,
                              ),
                              TextSpan(
                                text: "${listImages[index].empDeptdesc}",
                                style: smallStyle,
                              ),
                            ]),
                          ),
                        ),
                        Spacer(),
                        listImages[index].imStatus.toString() == 'Approve'
                            ? Text(
                                '${listImages[index].imDistance}',
                                style: apporveStyle,
                              )
                            : showStatus(index),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget showStatus(int index) {
    return listImages[index].imStatus.toString() == 'Waiting'
        ? Text(
            '${listImages[index].imDistance}',
            style: waitingStyle,
          )
        : Text(
            '${listImages[index].imDistance}',
            style: cancelStyle,
          );
  }
}
