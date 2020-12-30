import 'dart:io';

import 'package:brhhappy/happy_Run/model/message_run.dart';
import 'package:brhhappy/happy_Run/users/message/messagePhotoview.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewMessageRun extends StatefulWidget {
  final Messagerun messagerun;
  ViewMessageRun({Key key, this.messagerun}) : super(key: key);
  @override
  _ViewMessageRunState createState() => _ViewMessageRunState();
}

class _ViewMessageRunState extends State<ViewMessageRun> {
  Messagerun messageruns;
  String title, image, detail, tourl;
  File file;
  @override
  void initState() {
    super.initState();
    messageruns = widget.messagerun;
    tourl = messageruns.runMeurl;
    print('tourl>>>$tourl');
    title = messageruns.runMetitle;
    print('title>>>>$title');
    image = messageruns.runMeimage;
    print('imag>>>$image');
    detail = messageruns.runMedatails;
    print('detail>>>$detail');
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ShowBenner(size: size),
          Container(
            width: size.width * 1,
            height: size.height * 0.8,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 0),
                  child: Text(
                    '$title',
                    style: listtitleStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyViewPhotoMessageRun(
                          messagerun: messageruns,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    '${MyConstantRun().domain}message/$image',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    '$detail',
                    style: textStyle,
                  ),
                ),
                messageruns.runMeurl == 'null'
                    ? Icon(Icons.link_off_outlined)
                    : Padding(
                        padding: const EdgeInsets.all(20),
                        child: RaisedButton.icon(
                          color: Color(0xFF162A49),
                          icon: Icon(Icons.link_rounded),
                          label: Text('ไปยังอีกเว็บไซต์'),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          onPressed: () => launchURL(tourl),
                        ),
                      ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
