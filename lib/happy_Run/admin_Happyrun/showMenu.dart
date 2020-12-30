import 'package:brhhappy/happy_Run/admin_Happyrun/event_run/events.dart';
import 'package:brhhappy/happy_Run/admin_Happyrun/imageRun/swiper_image.dart';
import 'package:brhhappy/happy_Run/admin_Happyrun/message/message.dart';
import 'package:brhhappy/happy_Run/admin_Happyrun/reward/admin_listreward.dart';
import 'package:brhhappy/happy_Run/admin_Happyrun/reward/admin_reward.dart';
import 'package:brhhappy/happy_Run/users/ranking/users_rank.dart';
import 'package:brhhappy/ulility/addicon.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:flutter/material.dart';

import 'history/admin_history.dart';

class ShowMenuAdmin extends StatelessWidget {
  const ShowMenuAdmin({
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
        height: 340,
        decoration: BoxDecoration(
            color: Colors.pink.withOpacity(0.3),
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
                          builder: (context) => SwiperRunner(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/runner.png")),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminMessage(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/message2.png")),
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
                        builder: (context) => AdminEvent(),
                      ),
                    );
                  },
                  child: IconsCard(icon: "assets/images/messagedept.png"),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminReward(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/gifts.png")),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminRunHistory(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/history.png")),
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
                          builder: (context) => AdminListReward(),
                        ),
                      );
                    },
                    child: IconsCard(icon: "assets/images/gift.png")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
