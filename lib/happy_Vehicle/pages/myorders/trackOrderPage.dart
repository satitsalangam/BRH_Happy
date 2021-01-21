import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrackOrderPage extends StatefulWidget {
  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Track Order'.toUpperCase(),
          style: listtitleStyle,
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(
        //         Icons.notifications,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {})
        // ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Number 1001',
                style: listtitleStyle,
              ),
              Text(
                'Order Confirmed Ready to Pick',
                style: textStyle,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                height: 1,
                color: Colors.grey,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 13, top: 45),
                    width: 4,
                    height: 400,
                    color: Colors.grey,
                  ),
                  Column(
                    children: [
                      statusWidget("confirmed", "Comfirmed", true),
                      statusWidget("onBoard2", "Picked Up", true),
                      statusWidget("servicesImg", "InProcess", false),
                      statusWidget("shipped", "Shipped", false),
                      statusWidget("Delivery", "Delivered", false),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container statusWidget(String img, String status, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (isActive) ? Colors.orange : Colors.white,
              border: Border.all(
                  color: (isActive) ? Colors.transparent : Colors.orange,
                  width: 3),
            ),
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/$img.png'),
                      fit: BoxFit.contain),
                ),
              ),
              Text(
                status,
                style: textStyle.copyWith(
                    color: (isActive) ? Colors.orange : Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
