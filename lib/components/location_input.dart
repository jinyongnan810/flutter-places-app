import 'package:location/location.dart';

import 'package:flutter/material.dart';
import 'package:places/helpers/location_helper.dart';
import 'package:places/models/place.dart';

class LocationInput extends StatefulWidget {
  Function _saveLocation;
  LocationInput(this._saveLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  final Location location = Location();
  String? _previewImage;
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
    } catch (err) {
      print('no permission to location');
    }
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
                onPressed: () {},
                icon: Icon(Icons.map),
                label: Text('Find On Map')),
          ],
        )
      ],
    );
  }
}
