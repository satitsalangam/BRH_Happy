import 'dart:convert';
import 'dart:ui';

import 'package:brhhappy/happy_Money/addmin/slip_screen.dart';
import 'package:brhhappy/ulility/my_constantSlip.dart';
import 'package:brhhappy/ulility/my_constants.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/process_SingOut.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'histotry_screen.dart';
import 'list_data.dart';
import '../model/emp_slip.dart';

class Administator extends StatefulWidget {
  @override
  _AdministatorState createState() => _AdministatorState();
}

class _AdministatorState extends State<Administator>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  PageController pageController;
  bool loadStatus = true;
  bool loadProcess = true;
  bool loadImage = true;
  bool loadImages = true;
  List<Slip> slip = List();
  Image file;
  String path;
  String comment = "No comment";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSlip();

    tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  Future<void> normalDialogAppoved(
      BuildContext context, String title, Slip slip) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        Navigator.pop(context);
        print('slipid>>>>>${slip.moId}');
        String urlUpdate =
            '${MyConstant().domain}approveSlip.php?update=true&id=${slip.moId}';
        await Dio().get(urlUpdate).then(
              (value) => loadStatus ? MyStyle().showProgress() : readSlip(),
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
      BuildContext context, String title, Slip slip) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        Navigator.pop(context);
        print('slipid>>>>>${slip.moId}');
        print('command>>>>>$comment');
        String urlUpdate =
            '${MyConstant().domain}noApproveSlip.php?update=true&id=${slip.moId}&commend=$comment';
        await Dio().get(urlUpdate).then(
              (value) => loadStatus ? MyStyle().showProgress() : readSlip(),
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
              
              autofocus: true,
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

  Future<void> readSlip() async {
    if (slip.length != 0) {
      slip.clear();
    }
    String url = '${MyConstant().domain}getWaitingSlip.php?select=true';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('result>>>>>>>>>>$result');
        for (var map in result) {
          Slip slips = Slip.fromJson(map);
          setState(() {
            slip.add(slips);
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
    return Scaffold(
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: ListView(
            //  padding: EdgeInsets.symmetric(vertical: 30.0),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bangkok Hospital Rayong',
                      style: titleStyle,
                    ),
                    // IconButton(
                    //     icon: Icon(FontAwesomeIcons.signOutAlt),
                    //     onPressed: () {
                    //       processSignOut(context);
                    //     }),
                  ],
                ),
              ),
              TabBar(
                controller: tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.6),
                labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.home,
                    ),
                    child: Text('หน้าแรก', style: menuTextStyle),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistotryScreen(),
                        ),
                      );
                    },
                    child: Tab(
                      icon: Icon(
                        Icons.history,
                      ),
                      child: Text('ประวัติ', style: menuTextStyle),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListData(),
                        ),
                      );
                    },
                    child: Tab(
                      icon: Icon(Icons.receipt),
                      child: Text('รายการ', style: menuTextStyle),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.card_giftcard),
                    child: Text('ของรางวัล', style: menuTextStyle),
                  ),
                ],
              ),
              loadStatus ? MyStyle().showProgress() : showNoContent()
            ],
          ),
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
                  'ไม่มีรายการการส่งสลิปเงินฝาก',
                  style: titleStyle,
                ),
              ),
            ]),
          );
  }

  Widget showContent() {
    return Container(
      height: 500.0,
      width: double.infinity,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {});
        },
        itemCount: slip.length,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SlipScreen(slip: slip[index]),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[500],
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
                    onPressed: () => normalDialogAppoved(
                      context,
                      'คุณต้องการอนุมัติ ใช่หรือไม่',
                      Slip(moId: slip[index].moId),
                    ),
                  ),
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
                    // onPressed: () => showDialogCancel(),
                    onPressed: () => normalDialogNoAppoved(
                      context,
                      'คุณต้องการยกเลิกรายการ ใช่หรือไม่',
                      Slip(moId: slip[index].moId),
                    ),
                  ),
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
          '${MyConstantSlip().domain}id${slip[index].moId},savemoney.${slip[index].moImageSlip}'),
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
