import 'package:brhhappy/admin_screen.dart';
import 'package:brhhappy/happy_Run/admin_Happyrun/event_run/getListEvent.dart';
import 'package:brhhappy/happy_Run/admin_Happyrun/message/getListMessage.dart';
import 'package:brhhappy/happy_Run/admin_Happyrun/showMenu.dart';
import 'package:brhhappy/happy_Run/users/image_runner.dart';
import 'package:brhhappy/happy_Run/users/popular/popular_boy.dart';
import 'package:brhhappy/happy_Run/users/popular/popular_girl.dart';
import 'package:brhhappy/happy_Run/users/title_with_btn.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';

class HomeAdminHappyRun extends StatefulWidget {
  @override
  _HomeAdminHappyRunState createState() => _HomeAdminHappyRunState();
}

class _HomeAdminHappyRunState extends State<HomeAdminHappyRun> {
  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeAdminHappyRun(),
        ),
      );
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // FlutterStatusbarcolor.setStatusBarColor(Colors.blueAccent);q
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AdminScreen(),
                ),
                ModalRoute.withName('/'));
          },
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.6,
                    child: Stack(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(right: 20, left: 20, bottom: 0),
                          height: size.height * 0.2-64 ,
                          decoration: BoxDecoration(
                            color: kTextColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                                bottomRight: Radius.circular(36)),
                          ),
                          child: Center(
                            child: Text(
                              'BRH HAPPY RUN',
                              style: headingTextStyle,
                            ),
                          ),
                        ),
                             ShowMenuAdmin(),
                      ],
                    ),
                  ),
             
                  SizedBox(
                    height: 15,
                  ),
                  TitleWithMoreBtn(
                    title: "Popular Men".toUpperCase(),
                    press: () {},
                  ),
                  PopularBoy(),
                  SizedBox(
                    height: 15,
                  ),
                  TitleWithMoreBtn(
                    title: "Popular Women".toUpperCase(),
                    press: () {},
                  ),
                  PopularGirl(),
                  TitleWithMoreBtn(
                    title: "รายการ",
                    press: () {},
                  ),
                  ShowImageList(),
                  TitleWithMoreBtn(
                    title: "Message".toUpperCase(),
                    press: () {},
                  ),
                  ListMessage(),
                  TitleWithMoreBtn(
                    title: "event".toUpperCase(),
                    press: () {},
                  ),
                  ListEvent(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
