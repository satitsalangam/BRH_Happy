import 'dart:convert';

import 'package:brhhappy/happy_Run/model/listImage.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SwiperRunner extends StatefulWidget {
  @override
  _SwiperRunnerState createState() => _SwiperRunnerState();
}

class _SwiperRunnerState extends State<SwiperRunner> {
  List<ListImage> listimages = [];
  String comment = "No comment";
  bool loadStatus = true;
  bool loadProcess = true;
  String name;
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    if (listimages.length != null) {
      listimages.clear();
    }
    String url = '${MyConstantRun().domain}getAllListRun.php?select=true';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          ListImage listImage = ListImage.fromJson(map);
          setState(() {
            listimages.add(listImage);
          });
        }
      } else {
        setState(() {
          loadProcess = false;
        });
      }
    });
  }

  Future<void> normalDialogAppoved(
      BuildContext context, String title, ListImage listImages) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        Navigator.pop(context);
        print('slipid>>>>>${listImages.imId}');
        print('point>>>>>${listImages.imDistance}');
        print('empid>>>>${listImages.imEmpid}');
        String urlUpdate =
            '${MyConstantRun().domain}approve.php?update=true&empid=${listImages.imEmpid}&point=${listImages.imDistance}&id=${listImages.imId}';
        await Dio().get(urlUpdate).then(
              (value) => loadStatus ? MyStyle().showProgress() : readData(),
            );
      },
      gradient: LinearGradient(colors: [
        Color.fromRGBO(116, 116, 191, 1.0),
        Color.fromRGBO(52, 138, 199, 1.0)
      ]),
    );
    Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      style: AlertStyle(titleStyle: textStyle),
      buttons: [
        DialogButton(
          child: Text(
            "NO",
            style: textStyle,
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        ),
        dialogButton
      ],
    ).show();
  }

  Future<void> normalDialogNoAppoved(
      BuildContext context, String title, ListImage listImage) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        Navigator.pop(context);
        print('slipid>>>>>${listImage.imId}');
        print('comment>>>>>$comment');
        String url =
            '${MyConstantRun().domain}noApprove.php?update=true&id=${listImage.imId}&comment=$comment';
        await Dio().get(url).then(
              (value) => loadStatus ? MyStyle().showProgress() : readData(),
            );
      },
      gradient: LinearGradient(colors: [
        Color.fromRGBO(116, 116, 191, 1.0),
        Color.fromRGBO(52, 138, 199, 1.0)
      ]),
    );
    Alert(
      context: context,
      type: AlertType.warning,
      content: Row(
        children: [
          Expanded(
            child: TextFormField(
              maxLines: 3,
              onChanged: (value) => comment = value,
              style: textStyle,
              decoration: InputDecoration(
                labelText: 'กรุณาใส่เหตุผล',
                labelStyle: textStyle,
                hintMaxLines: 3,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      title: title,
      style: AlertStyle(titleStyle: textStyle),
      buttons: [
        DialogButton(
          child: Text(
            "NO",
            style: textStyle,
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        ),
        dialogButton
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.blueGrey.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowBenner(size: size),
            loadStatus ? MyStyle().showProgress() : showNoContent()
          ],
        ),
      ),
    );
  }

  Widget showNoContent() {
    return loadProcess
        ? showContent()
        : Container(
            child: Column(children: [
              SizedBox(
                height: 200,
              ),
              Center(
                child: Text(
                  'ไม่มีรายการการส่งวิ่ง',
                  style: titleStyle,
                ),
              ),
            ]),
          );
  }

  Widget showContent() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.8,
      // color: Colors.red,
      child: Swiper(
        itemCount: listimages.length,
        itemWidth: size.width - 2 * 20,
        // itemWidth: 360,
        layout: SwiperLayout.STACK,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              activeSize: 15, activeColor: blue, space: 2),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 20 * 2.5),
            width: size.width * 0.9,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.5,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white, boxShadow: [kBoxShadow]),
                  child: Image.network(
                    '${MyConstantRun().domain}image/${listimages[index].imImage}',
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: size.width * 0.6,
                              child: RichText(
                                overflow: TextOverflow.clip,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        "${listimages[index].empPnameTh} ${listimages[index].empPnamefullTh}\n"
                                            .toUpperCase(),
                                    style: textStyle,
                                  ),
                                  TextSpan(
                                    text: "${listimages[index].empDeptdesc}\n",
                                    style: datetimetStyle,
                                  ),
                                  TextSpan(
                                    text: "STATUS : ",
                                    style: textStyle,
                                  ),
                                  TextSpan(
                                    text: "${listimages[index].imStatus}",
                                    style: waitingStyle,
                                  ),
                                ]),
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${listimages[index].imDistance}',
                              style: listtitleStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RawMaterialButton(
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                                elevation: 2.0,
                                fillColor: Colors.black54,
                                child: Icon(
                                  FontAwesomeIcons.check,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  normalDialogAppoved(
                                    context,
                                    'คุณต้องการอนุมัติ ใช่หรือไม่',
                                    ListImage(
                                        imId: listimages[index].imId,
                                        imDistance:
                                            listimages[index].imDistance,
                                        imEmpid: listimages[index].imEmpid),
                                  );
                                }),
                            RawMaterialButton(
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                                elevation: 2.0,
                                fillColor: Colors.black54,
                                child: Icon(
                                  FontAwesomeIcons.times,
                                  color: Colors.red,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  normalDialogNoAppoved(
                                    context,
                                    'คุณต้องยกเลิกการอนุมัติ ใช่หรือไม่',
                                    ListImage(imId: listimages[index].imId),
                                  );
                                }),
                          ],
                        ),
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
}
