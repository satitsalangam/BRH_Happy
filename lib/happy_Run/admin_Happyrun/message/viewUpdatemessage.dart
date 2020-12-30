import 'package:brhhappy/happy_Run/admin_Happyrun/admin_home.dart';
import 'package:brhhappy/happy_Run/admin_Happyrun/message/adminPhotoMessage.dart';
import 'package:brhhappy/happy_Run/model/message_run.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminUpdadteMessage extends StatefulWidget {
  final Messagerun messagerun;
  AdminUpdadteMessage({Key key, this.messagerun}) : super(key: key);
  @override
  _AdminUpdadteMessageState createState() => _AdminUpdadteMessageState();
}

class _AdminUpdadteMessageState extends State<AdminUpdadteMessage> {
  Messagerun messageruns;
  String title, image, detail, tourl, status, id, newStatus;

  @override
  void initState() {
    super.initState();
    messageruns = widget.messagerun;
    id = messageruns.runMeid;
    print('id>>>$id');
    status = messageruns.runMeactive;
    print('status>>>$status');
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

  Future<void> normalDialogStatus(BuildContext context, String title) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: textStyle,
      ),
      onPressed: () async {
        print('id>>$id');
        print('status>>$newStatus');
        // changeModelBool(value);
        String url =
            '${MyConstantRun().domain}updateStatus.php?isupdate=true&id=$id&status=$newStatus';
        await Dio().get(url).then(
          (value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeAdminHappyRun()),
                ModalRoute.withName('/'));
            
          },
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              Text(
                'STATUS',
                style: statusStyle,
              ),
              SizedBox(
                width: 15,
              ),
              status == 'using'
                  ? Padding(
                      padding: const EdgeInsets.only(right: 40, bottom: 15),
                      child: IconButton(
                        icon: Icon(
                          Icons.toggle_on,
                          size: 45,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            newStatus = 'off using';
                            normalDialogStatus(
                                context, 'คุณต้องการปิดการใช้งาน ใช่หรือไม่');
                          });
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: IconButton(
                        icon: Icon(
                          Icons.toggle_off,
                          size: 45,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            newStatus = 'using';
                            normalDialogStatus(
                                context, 'คุณต้องการเปิดการใช้งาน ใช่หรือไม่');
                          });
                        },
                      ),
                    )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ShowBenner(size: size),
            Container(
              width: size.width * 1,
              height: size.height * 0.9,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),
                    child: Text(
                      '$title',
                      style: listtitleStyle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyViewPhotoAdminMessageRun(
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
                            label: Text('ไปยังเว็บไซต์ที่เกี่ยวข้อง'),
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
      ),
    );
  }
}
