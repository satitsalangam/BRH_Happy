import 'package:brhhappy/happy_CounterCheckin/users/userProfile/userProfileCCIN.dart';
import 'package:flutter/material.dart';

class Custombody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Stack(
        children: [
          // Container(
          //   height: size.height,
          //   width: size.width,
          //   color: blue.withOpacity(0.3),
          // ),
          Column(
            children: [
              SizedBox(
                height: size.height * 0.28,
              ),
              MyUserProfileCCIN(),
            ],
          ),
        ],
      ),
    );
  }
}
