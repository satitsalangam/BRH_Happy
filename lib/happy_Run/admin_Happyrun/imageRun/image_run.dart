import 'dart:convert';

import 'package:brhhappy/happy_Run/model/listImage.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ImageRunner extends StatefulWidget {
  @override
  _ImageRunnerState createState() => _ImageRunnerState();
}

class _ImageRunnerState extends State<ImageRunner>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  List<ListImage> listimages = [];
  String comment = "No comment";
  bool loadStatus = true;
  bool loadProcess = true;
  @override
  void initState() {
    super.initState();
    readData();

    pageController = PageController(initialPage: 0, viewportFraction: 0.8);
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
        String urlUpdate =
            '${MyConstantRun().domain}approve.php?update=true&id=${listImages.imId}';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  'ไม่มีรายการการส่งระยะทาง',
                  style: titleStyle,
                ),
              ),
            ]),
          );
  }

  Widget showContent() {
    return Container(
      height: 600.0,
      width: double.infinity,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {});
        },
        itemCount: listimages.length,
        itemBuilder: (context, index) {
          return productSelector(index);
        },
      ),
    );
  }

  Widget productSelector(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        // getImage(index);
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SlipScreen(slip: slip[index]),
          //   ),
          // );
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: showSlip(index),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 4.0,
              child: Row(
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
                          ListImage(imId: listimages[index].imId),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget showSlip(int index) {
    return Image(
      height: 420.0,
      width: 270.0,
      image: NetworkImage(
          '${MyConstantRun().domain}image/${listimages[index].imImage}'),
      fit: BoxFit.cover,
    );
  }
}

class SystemPadding extends StatelessWidget {
  final Widget child;

  SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
