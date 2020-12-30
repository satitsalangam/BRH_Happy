import 'package:brhhappy/happy_Run/users/reward/historyReward.dart';
import 'package:brhhappy/happy_Run/users/reward/listReward.dart';
import 'package:brhhappy/happy_Run/users/userHistory/history.dart';
import 'package:brhhappy/happy_Run/users/ranking/users_rank.dart';
import 'package:brhhappy/ulility/addicon.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:flutter/material.dart';

import 'bmi/input_page/input_page.dart';
import 'users_image.dart';

class ShowMenu extends StatelessWidget {
  const ShowMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 230,
        decoration: BoxDecoration(
            color: secondary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [kBoxShadow]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InputPage(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/bmi.png")),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryReward(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/gift.png")),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserPopular(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/ranking.png")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserRuner(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/run.png")),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListReward(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/gifts.png")),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserHistory(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/history.png")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
