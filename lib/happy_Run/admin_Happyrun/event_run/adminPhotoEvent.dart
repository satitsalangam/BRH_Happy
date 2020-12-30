import 'package:flutter/material.dart';
import 'package:brhhappy/happy_Run/model/message_run.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:photo_view/photo_view.dart';

class MyViewPhotoAdminEventRun extends StatefulWidget {
  final Messagerun messagerun;
  MyViewPhotoAdminEventRun({Key key, this.messagerun}) : super(key: key);
  @override
  _MyViewPhotoAdminEventRunState createState() => _MyViewPhotoAdminEventRunState();
}

class _MyViewPhotoAdminEventRunState extends State<MyViewPhotoAdminEventRun> {
  Messagerun messageruns;
  String image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageruns = widget.messagerun;
    image = messageruns.runMeimage;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 1,
      height: size.height * 1,
      child: PhotoView(
        imageProvider: NetworkImage('${MyConstantRun().domain}event/$image'),
      ),
    );
  }
}
