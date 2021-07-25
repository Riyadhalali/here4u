import 'dart:convert';

import 'package:http/http.dart' as http;

class WebServices {
  static Future<String?> getTimeBetweenDestinations(String sourceLong,
      String sourceLat, String destinationLong, String destinationLat) async {
    var url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$sourceLat,$sourceLong&destinations=$destinationLat,$destinationLong&key=AIzaSyA54WuN4cuPPdhHB5hW-ibaYJGF7ZB_1mE';
    String data;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        data = response.body;
        var decodedData = jsonDecode(data); // decoding data
        //var time = decodedData[0].elements[0].duration.text];
        print(data);
        return response.body;
      }
    } catch (e) {
      return 'error in getting data';
    }
  }
} //end class 1
