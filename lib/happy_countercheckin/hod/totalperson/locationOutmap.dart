import 'dart:collection';

import 'package:brhhappy/happy_countercheckin/models/managercounterlist.dart';
import 'package:brhhappy/happy_countercheckin/showBennerCounterCheckIN.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/narrow_app_bar.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationOutMaps extends StatefulWidget {
  final ManagerCounterList managerCounterlists;
  LocationOutMaps({Key key, this.managerCounterlists}) : super(key: key);
  @override
  _LocationOutMapsState createState() => _LocationOutMapsState();
}

class _LocationOutMapsState extends State<LocationOutMaps> {
  double lat1, lng1, lat2, lng2;
  ManagerCounterList managerCounterList;
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
    managerCounterList = widget.managerCounterlists;
    lat1 = double.parse(managerCounterList.ccLatCheackout);
    lng1 = double.parse(managerCounterList.ccLngCheackout);
    lat2 = double.parse(managerCounterList.ccRadiuslat);
    lng2 = double.parse(managerCounterList.ccRadiuslng);
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
          lat1 == null ? MyStyle().showProgress() : showMap()
        ],
      ),
      // body: Stack(
      //   children: [
      //     lat1 == null ? MyStyle().showProgress() : showMap(),
      //   ],
      // ),
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: GoogleMap(
          initialCameraPosition: cameraPosition,
          mapType: MapType.normal,
          onMapCreated: (controller) {},
          markers: myMarker(),
          circles: circles,
        ),
      ),
    );
  }
}
