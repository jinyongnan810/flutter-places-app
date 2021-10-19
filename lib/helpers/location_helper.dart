import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longtitude}) {
    final apiKey = dotenv.env['GOOGLE_MAP_API_KEY'];
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longtitude&key=$apiKey';
  }

  static Future<String> getPlaceName(LatLng pos) async {
    final apiKey = dotenv.env['GOOGLE_MAP_API_KEY'];
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${pos.latitude},${pos.longitude}&key=$apiKey');
    final res = await http.get(url);
    return jsonDecode(res.body)['results'][0]['formatted_address'];
  }
}
