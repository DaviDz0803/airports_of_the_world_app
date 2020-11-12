import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DistanceAirports extends StatefulWidget {
  @override
  _DistanceAirportsState createState() => _DistanceAirportsState();
}

class _DistanceAirportsState extends State<DistanceAirports> {
  Map airports;
  String destination;
  String origin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Distance')),
        body: Column(
          children: [
            _originInput(),
            _destinationInput(),
            FloatingActionButton(onPressed: () => Distance),
          ],
        ));
  }

  Future _getAirport() async {
    String _host = 'https://airports-of-the-world.herokuapp.com';
    String path = '/airports/routes/$origin-$destination?full=0';

    Dio dio = new Dio();

    Response response = await dio.get('$_host$path');

    airports = (response.data['data']);
    return airports;
  }

  Widget _originInput() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Origin',
      ),
      onChanged: (valor) {
        setState(() => origin = valor);
      },

      //placeholder
    );
  }

  Widget _destinationInput() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Destination',
      ),
      onChanged: (valor) {
        setState(() => destination = valor);
      },
      //placeholder
    );
  }

  Widget Distance() {
    return Container(
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
                            Text('Distance: ${snapshot.data['distance']}'),
                            Text('Origin: ${snapshot.data['originIata']}'),
                            Text(
                                'Destination: ${snapshot.data['destinationIata']}'),
                          ]),
                    ),
                  ),
                );
              }
            }));
  }
}
