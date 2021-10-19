import 'package:flutter/material.dart';
import 'package:places/models/place.dart';

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
      onTap: () {},
    );
  }
}
