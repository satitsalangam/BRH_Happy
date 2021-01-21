import 'dart:io';

import 'package:brhhappy/happy_countercheckin/models/managercounterlist.dart';
import 'package:brhhappy/ulility/my_constants_countercheckin.dart';
import 'package:brhhappy/ulility/my_constants_happyrun.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MyViewImageMessage extends StatefulWidget {
  final ManagerCounterList managerCounterLists;
  MyViewImageMessage({Key key, this.managerCounterLists}) : super(key: key);
  @override
  _MyViewImageMessageState createState() => _MyViewImageMessageState();
}

class _MyViewImageMessageState extends State<MyViewImageMessage> {
  ManagerCounterList managerCounterList;
  File file;
  String pathimage,image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    managerCounterList = widget.managerCounterLists;
    image = managerCounterList.empImg;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider:
            NetworkImage('${MyConstantRun().domain}ImagesProfile/$image'),
      ),
    );
  }
}
