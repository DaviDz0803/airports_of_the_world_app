import 'package:airports_challenge/src/routes/route.dart';
import 'package:flutter/material.dart';

import 'package:airports_challenge/src/views/list_airports.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ListAirports(),
      routes: getApplicationRoutes(),
    );
  }
}
