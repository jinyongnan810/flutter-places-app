import 'package:flutter/material.dart';
import 'package:places/models/place.dart';
import 'package:places/screens/place_detail_screen.dart';

class PlaceItem extends StatelessWidget {
  Place place;
  PlaceItem(this.place);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: FileImage(this.place.image),
      ),
      title: Text(this.place.title),
      subtitle: Text(this.place.location.address ?? ''),
      onTap: () {
        Navigator.of(context)
            .pushNamed(PlaceDetailScreen.routeName, arguments: this.place.id);
      },
    );
  }
}
