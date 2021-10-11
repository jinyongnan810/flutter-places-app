import 'package:flutter/material.dart';
import 'package:places/screens/place_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.amber),
      home: PlaceListScreen(),
    );
  }
}
