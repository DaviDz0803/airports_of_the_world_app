import 'package:flutter/material.dart';

import 'package:airports_challenge/src/views/list_airports.dart';
import 'package:airports_challenge/src/views/distance.dart';
import 'package:airports_challenge/src/views/detail_airports.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '': (context) => ListAirports(),
    'detail': (context) => DetailAirports(),
    'distance': (context) => DistanceAirports()
  };
}
