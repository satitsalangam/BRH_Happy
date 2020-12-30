
import 'package:brhhappy/ulility/my_constantSlip.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/emp_slip.dart';


class SlipScreen extends StatefulWidget {
  final Slip slip;

  SlipScreen({this.slip});

  @override
  _SlipScreenState createState() => _SlipScreenState();
}

class _SlipScreenState extends State<SlipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 30.0,
                    ),
                    height: 950.0,
                    color: Colors.blueGrey[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'ชื่อ :',
                                  style: textStyle,
                                ),
                                Text(
                                  widget.slip.empPnameTh,
                                  style: textStyle,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.slip.empPnamefullTh,
                                  style: textStyle,
                                ),
                              ],
                            ),
                            Text(widget.slip.moEmpid, style: numberStyle),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.slip.empDeptdesc,
                          style: departmentStyle,
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'FROM ',
                              style: textStyle,
                            ),
                            SizedBox(height: 10.0),
                            Text('\$${widget.slip.moMoney} Bath.',
                                style: numberStyle),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'Date : ',
                              style: textStyle,
                            ),
                            Text(
                              widget.slip.moDate,
                              style: numberStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 40.0),
                        SizedBox(height: 40.0),
                        // RawMaterialButton(
                        //   padding: EdgeInsets.all(20.0),
                        //   shape: CircleBorder(),
                        //   elevation: 2.0,
                        //   fillColor: Colors.black,
                        //   child: Icon(
                        //     Icons.add_shopping_cart,
                        //     color: Colors.white,
                        //     size: 35.0,
                        //   ),
                        //   onPressed: () => {},
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10.0,
                    bottom: 90.0,
                    child: Card(
                      child: Hero(
                        tag: widget.slip.moId,
                        child: Image(
                          height: MediaQuery.of(context).size.height * 0.8,
                          image: NetworkImage(
                              '${MyConstantSlip().domain}id${widget.slip.moId},savemoney.${widget.slip.moImageSlip}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
