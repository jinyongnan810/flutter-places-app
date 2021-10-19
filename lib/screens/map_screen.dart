import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place.dart';

class MapScreen extends StatefulWidget {
  LatLng initialLocation;
  bool isSetting;
  MapScreen(
      {this.initialLocation = const LatLng(35.82, 139.70),
      this.isSetting = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? location;
  void onTapMap(LatLng pos) {
    setState(() {
      this.location = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: widget.isSetting
            ? [
                IconButton(
                    onPressed: this.location == null
                        ? null
                        : () {
                            Navigator.of(context).pop(this.location);
                          },
                    icon: Icon(Icons.check)),
              ]
            : [],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude),
            zoom: 16),
        onTap: widget.isSetting ? onTapMap : null,
        markers: this.location == null
            ? {}
            : {
                Marker(
                    markerId: MarkerId('A'),
                    position: LatLng(
                        this.location!.latitude, this.location!.longitude))
              },
      ),
    );
  }
}
