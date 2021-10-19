import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:flutter/material.dart';
import 'package:places/helpers/location_helper.dart';
import 'package:places/models/place.dart';
import 'package:places/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  Function _saveLocation;
  LocationInput(this._saveLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  final Location location = Location();
  String? _previewImage;
  LatLng? _selectedPos;
  Future<void> _getCurrentLocation() async {
    try {
      final locData = await location.getLocation();
      widget._saveLocation(PlaceLocation(
          latitude: locData.latitude!, longitude: locData.longitude!));
      final previewImage = LocationHelper.generateLocationPreviewImage(
          latitude: locData.latitude!, longtitude: locData.longitude!);
      setState(() {
        _previewImage = previewImage;
      });
      _selectedPos = LatLng(locData.latitude!, locData.longitude!);
    } catch (err) {
      print('no permission to location');
    }
  }

  Future<void> _selectOnMap() async {
    LatLng? pos = await Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => _selectedPos == null
            ? MapScreen(
                isSetting: true,
              )
            : MapScreen(
                initialLocation: _selectedPos!,
                isSetting: true,
              )));
    if (pos == null) {
      return;
    }
    widget._saveLocation(
        PlaceLocation(latitude: pos.latitude, longitude: pos.longitude));
    final previewImage = LocationHelper.generateLocationPreviewImage(
        latitude: pos.latitude, longtitude: pos.longitude);
    setState(() {
      _previewImage = previewImage;
    });
    _selectedPos = pos;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.circular(5)),
          child: _previewImage == null
              ? Text('No Location Chosen.')
              : Image.network(
                  _previewImage!,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
                onPressed: () {
                  _getCurrentLocation();
                },
                icon: Icon(Icons.location_on),
                label: Text('Current Location')),
            TextButton.icon(
                onPressed: () {
                  _selectOnMap();
                },
                icon: Icon(Icons.map),
                label: Text('Find On Map')),
          ],
        )
      ],
    );
  }
}
