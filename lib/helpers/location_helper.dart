import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longtitude}) {
    final apiKey = dotenv.env['GOOGLE_MAP_API_KEY'];
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longtitude&key=$apiKey';
  }
}
