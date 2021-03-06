import 'dart:convert';

import 'package:brhhappy/happy_Run/model/image_run.dart';
import 'package:brhhappy/happy_Run/model/listImage.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListHistory extends StatefulWidget {
  @override
  _ListHistoryState createState() => _ListHistoryState();
}

class _ListHistoryState extends State<ListHistory> {
  List<ImageRun> imageRuns = List();
  bool loadStatus = true;
  bool loadProcess = true;

  @override
  void initState() {
    super.initState();
    readListHistory();
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      readListHistory();
    });
    return null;
  }

  Future<void> normalDialogNoAppoved(
      BuildContext context, String title, ImageRun imageRun) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        Navigator.pop(context);
        print('slipid>>>>>${imageRun.imId}');
        // print('comment>>>>>$comment');
        String url =
            '${MyConstantRun().domain}imageCancel.php?update=true&id=${imageRun.imId}';
        await Dio().get(url).then(
              (value) =>
                  loadStatus ? MyStyle().showProgress() : readListHistory(),
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

  Future<void> readListHistory() async {
    if (imageRuns.length != 0) {
      imageRuns.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantRun().domain}getHistory.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          ImageRun imageRun = ImageRun.fromJson(map);
          setState(() {
            imageRuns.add(imageRun);
          });
        }
      } else {
        loadProcess = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: loadStatus ? MyStyle().showProgress() : showNoContent(size),
      ),
    );
  }

  Widget showNoContent(Size size) {
    return loadProcess
        ? showContent(size)
        : Container(
            height: size.height * 0.6,
            child: Center(
              child: Text('ยังไม่มีประวัติรายการวิ่ง', style: titleStyle),
            ),
          );
  }

  Widget showContent(Size size) {
    return Container(
      //  color: Colors.blue,
      height: size.height * 0.65,
      child: RefreshIndicator(
        onRefresh: refreshList,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: imageRuns.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: size.height * 0.25,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [kBoxShadow]),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: size.width * 0.3,
                        height: size.height * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          child: Image(
                            image: NetworkImage(
                                "${MyConstantRun().domain}image/${imageRuns[index].imImage}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.run_circle_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${imageRuns[index].imDistance} กม.',
                                style: departmentStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.timer_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${imageRuns[index].imTimer}',
                                style: departmentStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${imageRuns[index].imDate} ',
                                style: departmentStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.star_outline),
                              SizedBox(
                                width: 10,
                              ),
                              imageRuns[index].imStatus.toString() == 'Approve'
                                  ? Text(
                                      '${imageRuns[index].imStatus} ',
                                      style: apporveStyle,
                                    )
                                  : imageRuns[index].imStatus.toString() ==
                                          'Waiting'
                                      ? Text('${imageRuns[index].imStatus} ',
                                          style: waitingStyle)
                                      : Text(
                                          '${imageRuns[index].imStatus} ',
                                          style: cancelStyle,
                                        ),
                            ],
                          ),
                        ),
                        imageRuns[index].imStatus == 'Waiting'
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: size.width * 0.5,
                                      decoration: ShapeDecoration(
                                        color: Colors.orangeAccent
                                            .withOpacity(0.5),
                                        shape: CircleBorder(),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.times,
                                          color: Colors.redAccent[400],
                                        ),
                                        onPressed: () {
                                          normalDialogNoAppoved(
                                            context,
                                            'คุณต้องการยกเลิกรายการใช่หรือไม',
                                            ImageRun(
                                                imId: imageRuns[index].imId),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : showComment(size, index),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget showComment(Size size, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Icon(Icons.comment_outlined),
          SizedBox(
            width: 10,
          ),
          Container(
            width: size.width * 0.45,
            child: imageRuns[index].imCommend.toString() != 'null'
                ? Text(
                    '${imageRuns[index].imCommend} ',
                    style: commentStyle,
                    overflow: TextOverflow.clip,
                    maxLines: 3,
                  )
                : Text(
                    'รายการวิ่งผ่านการอนุมัติ',
                    style: smallStyle,
                  ),
          ),
        ],
      ),
    );
  }
}
