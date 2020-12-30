import 'dart:convert';

import 'package:brhhappy/ulility/my_constants.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/money_slip.dart';

class ListData extends StatefulWidget {
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  bool loadmoney = true;
  Money moneys;
  String money;
  @override
  void initState() {
    super.initState();
    totalmoney();
  }

  Future<void> totalmoney() async {
    String url = "${MyConstant().domain}gettatalmoney.php?select=true";
    await Dio().get(url).then((value) {
      setState(() {
        loadmoney = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          setState(() {
            moneys = Money.fromJson(map);
            money = moneys.money;
          });
        }
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
          margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 50),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'รายการทั้งหมด',
                      style: listtitleStyle,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                          '--------------------------------------------------------------------'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    loadmoney ? MyStyle().showProgress() : showMoney(),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'จำนวนผู้เข้าร่วม :',
                    //         style: departmentStyle,
                    //       ),
                    //       Text(
                    //         '1000 คน',
                    //         style: departmentStyle,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'จำนวนสลิป :',
                    //         style: departmentStyle,
                    //       ),
                    //       Text(
                    //         '1000 ครั้ง',
                    //         style: departmentStyle,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'อนุมัติผ่าน :',
                    //         style: departmentStyle,
                    //       ),
                    //       Text(
                    //         '5000 ครั้ง',
                    //         style: departmentStyle,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'อนุมัติไม่ผ่าน :',
                    //         style: departmentStyle,
                    //       ),
                    //       Text(
                    //         '100 ครั้ง',
                    //         style: departmentStyle,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showMoney() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ยอดร่วมทั้งหมด :',
            style: departmentStyle,
          ),
          Text(
            '$money บาท',
            style: departmentStyle,
          )
        ],
      ),
    );
  }
}
