import 'package:flutter/material.dart';
import 'package:places/components/place_item.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatefulWidget {
  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  Future _load = Future(() {});
  @override
  void didChangeDependencies() {
    _load = Provider.of<GreatPlaces>(context, listen: false).load();
    super.didChangeDependencies();
  }

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
        body: FutureBuilder(
            future: _load,
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnapshot.hasError) {
                  print(dataSnapshot.error);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('Error loading the places.Please refresh again.'),
                    duration: Duration(seconds: 5),
                  ));
                }

                return Center(
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
                ));
              }
            }));
  }
}
