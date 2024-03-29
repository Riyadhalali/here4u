import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:here4u/webservices/webservices.dart';
import 'package:telephony/telephony.dart';

const LatLng SOURCE_LOCATION = LatLng(35.1367571, 36.787285); // المنطقة الصناعية - حماه
const LatLng DEST_LOCATION = LatLng(35.11274331472979, 36.75788764136045); // المشفى الوطني حماه

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);
  static const id = 'emergency_page';

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  Completer<GoogleMapController> _controller = Completer();
  double? lat;
  double? long;
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  late LatLng currentLocation;
  late LatLng destinationLocation;
  String? timeRequired;
  final Telephony telephony = Telephony.instance;

  //-------Get time between Source and Destination using Matrix Maps APi--------
  void getTime() {
    Future<String?> data = WebServices.getTimeBetweenDestinations(long.toString(), lat.toString(),
        DEST_LOCATION.longitude.toString(), DEST_LOCATION.latitude.toString());
  }

  //-> get the location of this device
  //-----------------------------------------Get Location-----------------------
  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double longitudeData = position.longitude;
    double latitudeData = position.latitude;
    setState(() {
      lat = latitudeData;
      long = longitudeData;
      currentLocation = LatLng(position.latitude, position.longitude);
      destinationLocation = LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
    });
    print(lat);
    print(long);
//-> get the time between the locations
    String? data = await WebServices.getTimeBetweenDestinations(long.toString(), lat.toString(),
        DEST_LOCATION.longitude.toString(), DEST_LOCATION.latitude.toString());
    setState(() {
      timeRequired = data.toString();
      print('time required is:');
      print(timeRequired);
    });
  }

//------------------------------------------------------------------------------
  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyA54WuN4cuPPdhHB5hW-ibaYJGF7ZB_1mE",
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(destinationLocation.latitude, destinationLocation.longitude));

    print('error message');
    print(result.errorMessage);
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyline'),
            color: Colors.red,
            points: polylineCoordinates));
        setState(() {});
      });
    }
  }

  //----------------------------Show Pins on Map-----------------------------
  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: currentLocation,
      ));

      _markers.add(Marker(
        markerId: MarkerId('destinationPin'),
        position: destinationLocation,
      ));
    });
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents).catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  //---------------------------------ٍSend Message directly without user interaction---------
  //-> also we can use something called sms manager
  void sendSmsDirectly() async {
    String message = "يرجى إرسال إسعاف إلى الموقع الحالي ";
    List<String> recipents = ["0964755094"];
    String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true)
        .catchError((onError) {
      print("error sms:$onError");
    });
    print(_result);
  }

  //
  void sendSMS_2() async {
    bool? permissionsGranted = await telephony.requestSmsPermissions;
    if (permissionsGranted == true) {
      print("permissions is granted");

      await telephony.sendSms(to: "0947505094", message: "يرجى إرسال إسعاف إلى الموقع الحالي ");
    } else {
      print("permissions is Not granted, please check");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    polylinePoints = PolylinePoints();
    getLocation();
    getTime(); // get time
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    sendSMS_2();
  }

  //------------------------------

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: lat == null || long == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat!, long!),
                    zoom: 15.0,
                  ),
                  markers: _markers,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  polylines: _polylines,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    showPinsOnMap();
                    setPolylines();
                  },
                  //-> this function will print the location of taped location on the maps
                  onTap: (LatLng loc) {
                    //  print(loc);
                  },
                ),
                Positioned(
                  bottom: 15.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        'الوقت المتوقع لوصول سيارة الإسعاف' + '\n' + timeRequired.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
