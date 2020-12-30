import 'dart:convert';
import 'package:brhhappy/ulility/my_constants.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/emp_slip.dart';

class HistotryScreen extends StatefulWidget {
  @override
  _HistotryScreenState createState() => _HistotryScreenState();
}

class _HistotryScreenState extends State<HistotryScreen> {
  bool loadStatus = true;
  bool loadProcess = true;
  List<Slip> slip = List();
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    String url = '${MyConstant().domain}getHistotrySlip.php?select=true';
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
      appBar: AppBar(
        title: Text(
          'Bangkok Hospital Rayong',
          style: titleStyle,
        ),
        elevation: 0,
      ),
      body: Form(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [loadStatus ? MyStyle().showProgress() : showContent()],
            ),
          ),
        ),
      ),
    );
  }

  Widget showContent() {
    return ListView.builder(
        itemCount: slip.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.4),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        slip[index].empPnameTh == 'นาย'
                            ? showAvatarMan()
                            : showAvatarWoman(),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${slip[index].moId}.',
                          style: numberStyle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'รหัส: ${slip[index].moEmpid}',
                          style: textStyle,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${slip[index].empPnamefullTh}',
                          style: textStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Status:',
                              style: textStyle,
                            ),
                            slip[index].moMoneyActive == 'Approve'
                                ? Text(
                                    '${slip[index].moMoneyActive}',
                                    style: apporveStyle,
                                  )
                                : showStatus(index)
                          ],
                        ),
                        Text(
                          '฿ :${slip[index].moMoney} Bath',
                          style: departmentStyle,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'แผนก:${slip[index].empDeptdesc}',
                          style: departmentStyle,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date:${slip[index].moDate}',
                          style: departmentStyle,
                        ),
                        Text(
                          '${slip[index].moUpdatedate}',
                          style: datetimetStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget showAvatarWoman() {
    return CircleAvatar(
      radius: 30,
      child: CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage('assets/images/avatarWomen.png'),
      ),
    );
  }

  Widget showAvatarMan() {
    return CircleAvatar(
      radius: 30,
      child: CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage('assets/images/avatarMan.png'),
      ),
    );
  }

  Widget showStatus(index) {
    return slip[index].moMoneyActive == 'Waiting'
        ? Text(
            '${slip[index].moMoneyActive}',
            style: waitingStyle,
          )
        : Text(
            '${slip[index].moMoneyActive}',
            style: cancelStyle,
          );
  }
}
