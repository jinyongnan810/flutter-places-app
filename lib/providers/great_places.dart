import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:places/helpers/db_helper.dart';
import 'package:places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];
  List<Place> get places {
    return [..._places];
  }

  Place get(int index) {
    return _places[index];
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
            location: location))
        .toList();
    notifyListeners();
  }

  Future<void> add(String title, File image, PlaceLocation location) async {
    final newPlace = Place(
        id: Random().nextInt(100000).toString(),
        title: title,
        image: image,
        location: location);
    _places.add(newPlace);
    await DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
    print(places);
    notifyListeners();
  }
}
