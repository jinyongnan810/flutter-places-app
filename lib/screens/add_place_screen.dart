import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/components/image_input.dart';
import 'package:places/components/location_input.dart';
import 'package:places/models/place.dart';
import 'package:places/providers/great_places.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static final String routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _image;
  PlaceLocation? _location;
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveImage(File image) {
    this._image = image;
  }

  void _saveLocation(PlaceLocation location) {
    this._location = location;
  }

  void _save() {
    if (_titleController.text.isEmpty || _image == null || _location == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .add(_titleController.text, _image!, _location!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Expanded will take all space available
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_saveImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_saveLocation)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _save();
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            style: ButtonStyle(
                // remove drop shadow
                elevation: MaterialStateProperty.all<double>(0),
                // remove margin
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                // remove border radius
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                // change color
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor)),
          ),
        ],
      ),
    );
  }
}
