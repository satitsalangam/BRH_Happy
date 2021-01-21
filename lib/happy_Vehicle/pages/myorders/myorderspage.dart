import 'package:brhhappy/happy_Vehicle/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:brhhappy/happy_Vehicle/pages/myorders/addMyitem.dart';
import 'package:brhhappy/happy_Vehicle/pages/myorders/trackOrderPage.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyOrdersPage extends StatefulWidget with NavigationStates {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            ListView(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'brh hppay by order'.toUpperCase(),
                      style: listtitleStyle,
                    ),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      clothWidget('cloth1', 'Trouser', '15', context),
                      clothWidget('cloth2', 'Jeans', '15', context),
                      clothWidget('cloth3', 'Jackets', '15', context),
                      clothWidget('cloth4', 'Shirt', '15', context),
                      clothWidget('cloth5', 'T-Shirt', '15', context),
                      clothWidget('cloth6', 'Bla', '15', context),
                      clothWidget('cloth7', 'Trouser', '15', context),
                      clothWidget('cloth8', 'Trouser', '15', context),
                      clothWidget('cloth9', 'Trouser', '15', context),
                    ],
                  ),
                ))
                // Column(
                //   children: [],
                // ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          // Cannot be `Alignment.center`
          alignment: Alignment.bottomRight,
          ringColor: Colors.blue.withAlpha(25),
          ringDiameter: 500.0,
          ringWidth: 150.0,
          fabSize: 64.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),
          // Also can use specific color based on wether
          // the menu is open or not:
          // fabOpenColor: Colors.white
          // fabCloseColor: Colors.white
          // These properties take precedence over fabColor
          fabColor: kTextColor,
          fabOpenIcon: Icon(Icons.menu, color: Colors.white),
          fabCloseIcon: Icon(Icons.close, color: Colors.white),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) {
            _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
          },
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(context, "You pressed 1");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kTextColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                // _showSnackBar(context, "You pressed 2");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kTextColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                _showSnackBar(context, "You pressed 3");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kTextColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAdditemVehicle(),
                  ),
                );
                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kTextColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: txt_style,
        ),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }
}

Container clothWidget(
    String img, String name, String price, BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    // width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/$img.png'),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: listtitleStyle,
                    ),
                    Text(
                      '\$$price',
                      style: listtitleStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      'Add Note',
                      style: textStyle.copyWith(color: Colors.orange),
                    ),
                  ],
                ),
                Text(
                  '\$45',
                  style: headerStyle.copyWith(color: Colors.black),
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.shippingFast,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrackOrderPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ]),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 1,
            width: size.width * 0.75,
            color: Colors.black,
          ),
        ]),
      ],
    ),
  );
}
