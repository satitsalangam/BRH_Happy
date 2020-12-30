import 'package:brhhappy/happy_CounterCheckin/users/components/buttom_navigation.dart';
import 'package:brhhappy/happy_CounterCheckin/users/components/custom_app_bar.dart';
import 'package:brhhappy/happy_CounterCheckin/users/components/custom_body.dart';
import 'package:brhhappy/happy_CounterCheckin/users/userProfile/profileCounterCheckin.dart';
import 'package:brhhappy/happy_Doctor/home_doctor/components/custom_botton_navigation.dart';
import 'package:flutter/material.dart';

class UserHomeCounterChackIN extends StatefulWidget {
  @override
  _UserHomeCounterChackINState createState() => _UserHomeCounterChackINState();
}

class _UserHomeCounterChackINState extends State<UserHomeCounterChackIN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            CounterCheckINAppBar(),
            Custombody(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ProfilePicture(),
                ),
              ],
            ),
            CustomBottomNavigationBar(),

            CounterCheckinNavigation(),
            // CustomBottomCounterCheckIN()
          ],
        ),
      ),
    );
  }
}
