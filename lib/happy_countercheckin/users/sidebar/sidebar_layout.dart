import 'package:brhhappy/happy_countercheckin/users/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';
import '../../../happy_Vehicle/sidebar/sidebar.dart';

class SideBarCheckINLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBarCheckIN(),
          ],
        ),
      ),
    );
  }
}
