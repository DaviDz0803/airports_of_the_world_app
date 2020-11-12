import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DetailAirports extends StatefulWidget {
  String iata;
  DetailAirports({this.iata});

  @override
  _DetailAirportsState createState() => _DetailAirportsState(iata);
}

class _DetailAirportsState extends State<DetailAirports> {
  String iata;
  _DetailAirportsState(this.iata);

  Map airports;
  // getAirport();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Detail')),
        body: Container(
            child: FutureBuilder(
                future: _getAirport(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text("Loading..."),
                    );
                  } else {
                    return Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        child: Card(
                          shadowColor: Colors.black26,
                          color: Colors.lightGreen[100],
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Name: ${snapshot.data['name']}'),
                                Text('City: ${snapshot.data['city']}'),
                                Text('Country: ${snapshot.data['country']}'),
                                Text('IATA: ${snapshot.data['IATA']}'),
                                Text('ICAO: ${snapshot.data['ICAO']}'),
                                Text('Latitude: ${snapshot.data['latitude']}'),
                                Text('longitude: ${snapshot.data['latitude']}'),
                                Text('Altitude: ${snapshot.data['altitude']}'),
                                Text('TimeZone: ${snapshot.data['timezone']}'),
                                Text('DST: ${snapshot.data['dst']}'),
                              ]),
                        ),
                      ),
                    );
                  }
                })));
  }

  Future _getAirport() async {
    String _host = 'https://airports-of-the-world.herokuapp.com';
    String path = '/airports/iata/';

    Dio dio = new Dio();

    Response response = await dio.get('$_host$path$iata');

    airports = (response.data['data']);
    return airports;
  }
}
