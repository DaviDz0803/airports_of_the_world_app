// import 'package:airports_challenge/src/repository/get_airports.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:airports_challenge/src/views/detail_airports.dart';

class ListAirports extends StatefulWidget {
  @override
  _ListAirportsState createState() => _ListAirportsState();
}

class _ListAirportsState extends State<ListAirports> {
  int limit = 9;

  List<dynamic> airports = new List();
  String airport;
  ScrollController _scrollController = new ScrollController();

  //Class
  @override
  void initState() {
    super.initState();

    allAirports();
    if (airports != null) {
      if (airports.length == 0) {
        _scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            allAirports();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Airports List'),
        ),
        body: Column(
          children: [
            _createInput(),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  itemCount: airports.length,
                  itemBuilder: (BuildContext context, int index) {
                    String iata = '${airports[index]['IATA']}';

                    return Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                                offset: Offset(2.0, -10))
                          ]),
                      constraints: BoxConstraints.tightFor(height: 105.0),
                      child: ListTile(
                          leading: Text(
                            "$index.   ${airports[index]['name']}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    DetailAirports(iata: iata)));
                          }),
                    );
                  }),
            ),
          ],
        ));
  }

  allAirports() async {
    String _host = 'https://airports-of-the-world.herokuapp.com'; //TODO Get out
    String path = '/airports?limit=';
    limit = limit + 9;

    Dio dio = new Dio();

    Response response = await dio.get('$_host$path$limit');
    setState(() {
      airports = (response.data['data']['data']);
    });
  }

  Widget _createInput() {
    return TextField(
        //autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Write an airport',
        ),
        onChanged: (valor) {
          setState(() => airport = valor);
        },
        onSubmitted: (airport) {
          getAirports(airport);
        }
        //placeholder
        );
  }

  void getAirports(airport) async {
    String _host = 'https://airports-of-the-world.herokuapp.com'; //TODO Get out
    String path = '/airports?';
    String query = 'name=$airport&city=$airport&country=$airport&fullMatch=0';

    Dio dio = new Dio();

    Response response = await dio.get('$_host$path$query');
    setState(() {
      airports = (response.data['data']['data']);
    });
  }
}
