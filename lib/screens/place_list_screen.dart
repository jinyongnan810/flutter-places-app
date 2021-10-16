import 'package:flutter/material.dart';
import 'package:places/components/place_item.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Consumer<GreatPlaces>(
          child: Center(
            child: Text('No places yet.'),
          ),
          builder: (ctx, places, ch) {
            if (places.places.length == 0) {
              return ch!;
            }
            return ListView.builder(
              itemBuilder: (ctx, index) => PlaceItem(places.get(index)),
              itemCount: places.places.length,
            );
          },
        ),
      ),
    );
  }
}
