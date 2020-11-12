import 'package:dio/dio.dart';

allAirports() async {
  String _host = 'https://airports-of-the-world.herokuapp.com';
  String path = '/airports';

  Dio dio = new Dio();
  List<dynamic> airports;

  Response response = await dio.get('$_host$path');
  airports = (response.data['data']['data']);
  return airports;
}

// final Uri apiUri = Uri(
//     host: 'airports-of-the-world.herokuapp.com',
//     port: 443,
//     path: '/airports');
