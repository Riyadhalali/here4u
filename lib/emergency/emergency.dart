import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);
  static const id = 'emergency_page';

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage>
    with AutomaticKeepAliveClientMixin {
  Completer<GoogleMapController> _controller = Completer();
  double? lat;
  double? long;

  List<Marker> _markers = <Marker>[];
  @override
  bool get wantKeepAlive => true;
  //-> get the location of this device
  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double longitudeData = position.longitude;
    double latitudeData = position.latitude;
    setState(() {
      lat = latitudeData;
      long = longitudeData;
    });
    print(lat);
    print(long);

    _markers.add(Marker(
        markerId: MarkerId('Location'),
        position: LatLng(latitudeData, longitudeData),
        infoWindow: InfoWindow(title: 'Location')));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: lat == null || long == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat!, long!),
                zoom: 15.0,
              ),
              markers: Set<Marker>.of(_markers),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
