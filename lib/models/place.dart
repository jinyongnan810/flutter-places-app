import 'dart:io';

class PlaceLocation {
  final double longitude;
  final double latitude;
  final String? address;
  const PlaceLocation(
      {required this.longitude, required this.latitude, this.address});
}

class Place {
  String id;
  String title;
  File image;
  PlaceLocation location;
  Place(
      {required this.id,
      required this.title,
      required this.image,
      required this.location});
}
