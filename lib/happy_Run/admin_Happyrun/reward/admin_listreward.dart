import 'package:brhhappy/happy_Run/admin_Happyrun/reward/list_reward.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:flutter/material.dart';

class AdminListReward extends StatefulWidget {
  @override
  _AdminListRewardState createState() => _AdminListRewardState();
}

class _AdminListRewardState extends State<AdminListReward> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShowBenner(size: size),
            AdminRewardList(),
          ],
        ),
      ),
    );
  }
}
