import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];
  List<Place> get places {
    return [..._places];
  }

  Place get(int index) {
    return _places[index];
  }

  void add(String title, File image) {
    final location = PlaceLocation(longitude: 10, latitude: 10);
    final newPlace = Place(
        id: Random().nextInt(100000).toString(),
        title: title,
        image: image,
        location: location);
    _places.add(newPlace);
    print(places);
    notifyListeners();
  }
}
