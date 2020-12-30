import 'package:brhhappy/happy_Run/users/popular/popular_girl.dart';
import 'package:brhhappy/happy_Run/users/popular/popularall_boy.dart';
import 'package:brhhappy/ulility/constants.dart';
import 'package:brhhappy/ulility/showBenner.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';

import '../title_with_btn.dart';

class UserPopular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShowBenner(size: size),
            TitleWithMoreBtn(
              title: "Ranking Men".toUpperCase(),
              press: () {},
            ),
            PopularAllBoy(),
            TitleWithMoreBtn(
              title: "Ranking Women".toUpperCase(),
              press: () {},
            ),
            PopularGirl(),
          ],
        ),
      ),
    );
  }
}
