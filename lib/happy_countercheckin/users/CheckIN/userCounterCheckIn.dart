import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:brhhappy/happy_CounterCheckin/models/countercheackin.dart';
import 'package:brhhappy/happy_CounterCheckin/models/department.dart';
import 'package:brhhappy/happy_CounterCheckin/models/locationMaps.dart';
import 'package:brhhappy/happy_CounterCheckin/showBennerCounterCheckIN.dart';
import 'package:brhhappy/happy_CounterCheckin/users/user_home.dart';
import 'package:brhhappy/happy_countercheckin/users/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:brhhappy/ulility/my_constants_countercheckin.dart';
import 'package:brhhappy/ulility/my_stayle.dart';
import 'package:brhhappy/ulility/normal_dialog.dart';
import 'package:brhhappy/ulility/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCheackIn extends StatefulWidget with NavigationStates {
  @override
  _UserCheackInState createState() => _UserCheackInState();
}

class _UserCheackInState extends State<UserCheackIn> {
  double lat1, lng1, lat2, lng2, distance;
  bool loadMap = true;
  bool loadloaction = true;
  bool loadLatLng = true;
  bool loadStatus = true;
  bool loadProcess = true;
  bool status = true;
  Set<Circle> circles = HashSet<Circle>();
  String selectedName,
      userType,
      userDepartment,
      id,
      mapid,
      locationName,
      userlocationname;
  List data = List();
  List locationmaps = List();
  LocationGoogleMaps locationGoogleMaps;
  UserDepartment departments;
  CounterCheackin counterCheackin;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    readLoactionMaps();
    readData();
    readDepartment();
    location.onLocationChanged.listen((event) {
      setState(() {
        lat1 = event.latitude;
        lng1 = event.longitude;
      });
    });
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  Future<void> readLatLng() async {
    print('location>>>>>>>$location');
    String urlGetData =
        "${MyConstantCounterCheckIN().domain}getLatLngMaps.php?select=true&locationName=$locationName";
    await Dio().get(urlGetData).then((value) {
      setState(() {
        findLatLng();
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('result>>>>>>>>>$result');
        for (var map in result) {
          setState(() {
            locationGoogleMaps = LocationGoogleMaps.fromJson(map);
            lat2 = double.parse(locationGoogleMaps.mapLat);
            lng2 = double.parse(locationGoogleMaps.mapLng);
          });
        }
      }
    });
  }

  Future<void> setCircles(double lat2, double lng2) async {
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

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    double distance = 0;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));

    return distance;
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String empid = preferences.getString('empid');
    String url =
        '${MyConstantCounterCheckIN().domain}getCounterCheckInOut.php?select=true&empid=$empid';
    await Dio().get(url).then((value) {
      setState(() {
        status = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          setState(() {
            counterCheackin = CounterCheackin.fromJson(map);
            id = counterCheackin.ccId;
            userType = counterCheackin.ccType;
            userDepartment = counterCheackin.dsDesc;
            userlocationname = counterCheackin.ccLoactionname;
            lat2 = double.parse(counterCheackin.ccRadiuslat);
            lng2 = double.parse(counterCheackin.ccRadiuslng);
            print('usertype>>>>$userType');
            print('userDepartment>>>>$userDepartment');
            print('userloaction>>>>$userlocationname');
            print('lat2>>>>>$lat2');
            print('lng2>>>>>$lng2');
            findLatLng();
          });
        }
      } else {}
    });
  }

  Future<void> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      // lat1 = locationData.latitude;
      // lng1 = locationData.longitude;
      print('lat1>>>$lat1');
      print('lng1>>>$lng1');
      lat1 = lat1;
      lng1 = lng1;
      lat2 = lat2;
      lng2 = lng2;
      setCircles(lat2, lng2);
      distance = calculateDistance(lat1, lng1, lat2, lng2);
      loadLatLng = false;
      print('distance>>>>>>>>$distance');
      print('lat>>$lat1, lng>>>>$lng1');
    });
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Future<void> readDepartment() async {
    String urlLoad =
        '${MyConstantCounterCheckIN().domain}getDepartment.php?select=true';
    await Dio().get(urlLoad).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('result>>>>>>>>>>>>$result');

        setState(() {
          data = result;
        });
        print('department>>>>>$result');
        return "success";
      } else {
        // setState(() {
        //   loadProcess = false;
        // });
      }
    });
  }

  Future<void> readLoactionMaps() async {
    String urlLoad =
        '${MyConstantCounterCheckIN().domain}getLocationMaps.php?select=true';
    await Dio().get(urlLoad).then((value) {
      setState(() {
        loadloaction = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('loactionMaps>>>>>>>>>>>>$result');
        setState(() {
          locationmaps = result;
        });
        print('loactionMaps>>>>>$result');
        return "success";
      } else {
        setState(() {
          loadProcess = false;
        });
      }
    });
  }

  Future<void> normalDialogCheackIn(
      BuildContext context, String titles, UserDepartment department) async {
    var dialogButton = DialogButton(
      child: Text(
        "ใช่",
        style: GoogleFonts.pridi(color: Colors.white, fontSize: 20),
      ),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String empid = preferences.getString('empid');
        print('empid>>>>$empid');
        print('depid>>>>$selectedName');
        print('lat>>>>>$lat1');
        print('lng>>>>>$lng1');
        print('userType>>>>$userType');
        print('locationName>>>$locationName');
        Navigator.pop(context);
        String url =
            '${MyConstantCounterCheckIN().domain}addCountercheackin.php?insert=true&empid=$empid&deptid=$selectedName&type=$userType&lat=$lat1&lng=$lng1&radlat=$lat2&radlng=$lng2&locationname=$locationName';
        await Dio()
            .get(url)
            .then((value) => status ? MyStyle().showProgress() : readData());
      },
      gradient: LinearGradient(colors: [
        Color.fromRGBO(116, 116, 191, 1.0),
        Color.fromRGBO(52, 138, 199, 1.0)
      ]),
    );
    Alert(
      context: context,
      type: AlertType.warning,
      title: titles,
      style: AlertStyle(titleStyle: GoogleFonts.pridi(fontSize: 15.0)),
      buttons: [
        DialogButton(
          child: Text(
            "ไม่ใช่",
            style: GoogleFonts.pridi(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        ),
        dialogButton
      ],
    ).show();
  }

  Future<void> normalDialogCheackOut(
      BuildContext context, String titles, UserDepartment department) async {
    var dialogButton = DialogButton(
      child: Text(
        "ใช่",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      onPressed: () async {
        print('id>>>>$id');
        Navigator.of(context).pop();
        String url =
            '${MyConstantCounterCheckIN().domain}addCountercheackOut.php?update=true&id=$id&lat=$lat1&lng=$lng1';
        await Dio().get(url).then(
              (value) => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserHomeCounterChackIN(),
                ),
              ),
            );
      },
      gradient: LinearGradient(colors: [
        Color.fromRGBO(116, 116, 191, 1.0),
        Color.fromRGBO(52, 138, 199, 1.0)
      ]),
    );
    Alert(
      context: context,
      type: AlertType.warning,
      title: titles,
      style: AlertStyle(titleStyle: TextStyle(fontSize: 15.0)),
      buttons: [
        DialogButton(
          child: Text(
            "ไม่ใช่",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        ),
        dialogButton
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                decoration: BoxDecoration(color: Colors.white10),
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                // padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Text(
                          'counter check in'.toUpperCase(),
                          style: listtitleStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          counterCheackin == null
                              ? showTextloactionMap()
                              : showTextloactionMap2(),
                          SizedBox(
                            height: 10.0,
                          ),
                          userlocationname == null
                              ? showLocationMaps()
                              : showUserlocationMap(),
                          SizedBox(
                            height: 10.0,
                          ),
                          counterCheackin == null ? showText() : showText2(),
                          SizedBox(
                            height: 10.0,
                          ),
                          userDepartment == null
                              ? showDepartment()
                              : status
                                  ? MyStyle().showProgress()
                                  : showUserdepartment(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                showTraining(),
                                showHelp(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                userDepartment != null
                                    ? showNull()
                                    : showCheackIn(context),
                                userDepartment == null
                                    ? showCheackOut2(context)
                                    : showCheackOut(context)
                              ],
                            ),
                          ),
                          loadloaction ? MyStyle().showProgress() : Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: showNoContent(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showNoContent() {
    return lat1 != null
        ? showMap()
        : Container(
            height: 200,
            child: Center(
              child: Text(
                'ท่านยังไม่เลือก Location ที่ต้องการ',
                style: textStyle,
              ),
            ),
          );
  }

  Widget showTextloactionMap() {
    return Text(
      'กรุณาเลือกเลือกสถานทีที่จะช่วยเหลืองาน',
      style:
          textStyle.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget showTextloactionMap2() {
    return Text(
      'สถานทีที่ท่านไปช่วยเหลืองานในวันนี้',
      style:
          textStyle.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget showText() {
    return Text(
      'กรุณาเลือกแผนกที่ท่านจะไปช่วยงาน',
      style:
          textStyle.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget showText2() {
    return Text(
      'แผนกที่ท่านไปช่วยงานในวันนี้',
      style:
          textStyle.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget showNull() {
    return Text('');
  }

  Widget showTraining() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Radio(
          value: 'Training',
          groupValue: userType,
          onChanged: (value) {
            setState(() {
              userType = value;
            });
          }),
      Text('ฝึกงาน', style: titleStyle),
    ]);
  }

  Widget showHelp() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Radio(
          value: 'Help',
          groupValue: userType,
          onChanged: (value) {
            setState(() {
              userType = value;
            });
          }),
      Text('ช่วยงาน', style: titleStyle),
    ]);
  }

  Widget showCheackOut2(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFCDDDD),
          ),
          child: IconButton(
              icon: Icon(
                FontAwesomeIcons.streetView,
                size: 30,
                color: Colors.red,
              ),
              onPressed: () {
                normalDialog(context, 'กรุณากด CheckIn เพื่อเข้าช่วยงานก่อน');
              }),
        ),
        Text(
          'CheackOut',
          style: titleStyle,
        ),
      ],
    );
  }

  Widget showCheackOut(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFCDDDD),
          ),
          child: IconButton(
              icon: Icon(
                FontAwesomeIcons.streetView,
                size: 30,
                color: Colors.red,
              ),
              onPressed: () {
                normalDialogCheackOut(
                    context, 'คุณต้องการ CheackOut ใช่หรือไม่', departments);
              }),
        ),
        Text(
          'CheackOut',
          style: titleStyle,
        ),
      ],
    );
  }

  Widget showCheackIn(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFDAFDED),
          ),
          child: IconButton(
              icon: Icon(
                FontAwesomeIcons.streetView,
                size: 30,
                color: Colors.green,
              ),
              onPressed: () {
                if (selectedName == null || selectedName.isEmpty) {
                  normalDialog(context, 'กรุณาเลือกแผนกที่ท่านมาช่วยงาน');
                } else if (userType == null || userType.isEmpty) {
                  normalDialog(context, 'กรุณาเลือกประเภทการช่วยเหลืองาน');
                } else if (distance >= 0.1) {
                  normalDialog(context, 'ท่านไม่ได้อยู่ในบริเวณที่กำหนด');
                } else {
                  normalDialogCheackIn(
                      context, 'คุณต้องการ CheackIn ใช่หรือไม่', departments);
                }
              }),
        ),
        Text(
          'CheackIn',
          style: titleStyle,
        ),
      ],
    );
  }

  Widget showUserdepartment() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.greenAccent[100]),
        child: IgnorePointer(
            ignoring: true,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  // value: selectedName,
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  // isDense: true,
                  items: data.map((list) {
                    return DropdownMenuItem(
                      child: Text(
                        userDepartment,
                        style: titleStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {}),
            )),
      ),
    );
  }

  Widget showUserlocationMap() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blueAccent[100]),
        child: IgnorePointer(
            ignoring: true,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  // isDense: true,
                  items: data.map((list) {
                    return DropdownMenuItem(
                      child: Text(
                        userlocationname,
                        style: titleStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {}),
            )),
      ),
    );
  }

  Widget showLocationMaps() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blueAccent[100]),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              value: locationName,
              hint: Text(
                'Select Location Maps ',
                style: titleStyle,
              ),
              icon: Icon(Icons.arrow_drop_down),
              isExpanded: true,
              // isDense: true,
              items: locationmaps.map((list) {
                return DropdownMenuItem(
                  child: Text(
                    list['map_loactionname'],
                    style: departmentStyle,
                  ),
                  value: list['map_loactionname'].toString(),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  locationName = value;
                  readLatLng().then((value) {});
                  print("loactionName>>>$locationName");
                });
              }),
        ),
      ),
    );
  }

  Widget showDepartment() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.greenAccent[100]),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              value: selectedName,
              hint: Text(
                'Select Department',
                style: titleStyle,
              ),
              icon: Icon(Icons.arrow_drop_down),
              isExpanded: true,
              // isDense: true,
              items: data.map((list) {
                return DropdownMenuItem(
                  child: Text(
                    list['ds_desc'],
                    style: departmentStyle,
                  ),
                  value: list['ds_id'].toString(),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedName = value;
                  print(selectedName);
                });
              }),
        ),
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
      zoom: 16.0,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
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
