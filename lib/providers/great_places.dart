import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/helpers/db_helper.dart';
import 'package:places/helpers/location_helper.dart';
import 'package:places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];
  List<Place> get places {
    return [..._places];
  }

  Place get(int index) {
    return _places[index];
  }

  Place getById(String id) {
    return _places.firstWhere((element) => element.id == id);
  }

  Future<void> load() async {
    final items = await DBHelper.fetchAll('places');
    if (items.isEmpty) return;
    final location = PlaceLocation(longitude: 10, latitude: 10);
    _places = items
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['loc_address'])))
        .toList();
    notifyListeners();
  }

  Future<void> add(String title, File image, PlaceLocation location) async {
    final placeName = await LocationHelper.getPlaceName(
        LatLng(location.latitude, location.longitude));
    print('address: $placeName');
    final fullLocation = PlaceLocation(
        longitude: location.longitude,
        latitude: location.latitude,
        address: placeName);
    final newPlace = Place(
        id: Random().nextInt(100000).toString(),
        title: title,
        image: image,
        location: fullLocation);
    _places.add(newPlace);
    await DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'loc_address': newPlace.location.address ?? ''
    });
    // print(places);
    notifyListeners();
  }
}
