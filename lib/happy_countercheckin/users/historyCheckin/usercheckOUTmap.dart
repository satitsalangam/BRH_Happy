import 'dart:collection';

import 'package:brhhappy/happy_CounterCheckin/models/countercheackin.dart';
import 'package:brhhappy/happy_CounterCheckin/showBennerCounterCheckIN.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserOutLoactionMaps extends StatefulWidget {
  final CounterCheackin counterCheackin;
  UserOutLoactionMaps({Key key, this.counterCheackin}) : super(key: key);
  @override
  _UserOutLoactionMapsState createState() => _UserOutLoactionMapsState();
}

class _UserOutLoactionMapsState extends State<UserOutLoactionMaps> {
  double lat1, lng1, lat2, lng2;
  CounterCheackin counterCheackins;
  bool loadStatus = true;
  bool loadProcess = true;
  bool status = true;
  Set<Circle> circles = HashSet<Circle>();
  String selectedName, userType, userDepartment, id;
  List data = List();
  Location location = Location();

  @override
  void initState() {
    super.initState();
    // lat2 = 12.674499;
    // lng2 = 101.221513;

    // findLatLng();
    counterCheackins = widget.counterCheackin;
    lat1 = double.parse(counterCheackins.ccLatCheackout);
    lng1 = double.parse(counterCheackins.ccLngCheackout);
    lat2 = double.parse(counterCheackins.ccRadiuslat);
    lng2 = double.parse(counterCheackins.ccRadiuslng);
    setCircles(lat2, lng2);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  Future<void> setCircles(lat2, lng2) async {
    circles.add(
      Circle(
        circleId: CircleId("BRH"),
        center: LatLng(lat2, lng2),
        radius: 100,
        strokeWidth: 2,
        strokeColor: Colors.green,
        fillColor: Colors.green.withOpacity(0.3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ShowBennerCounterCheckIN(size: size),
          lat1 == null ? MyStyle().showProgress() : showMap(),
        ],
      ),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myCounterCheackin'),
        position: LatLng(lat1, lng1),
        infoWindow: InfoWindow(
          title: 'ตำแหน่งของคุณ',
          snippet: 'ละติจูด =$lat1, ลองติจูต= $lng1',
        ),
      ),
    ].toSet();
  }

  Widget showMap() {
    LatLng latLng = LatLng(lat1, lng1);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 17.0,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
        circles: circles,
      ),
    );
  }
}
