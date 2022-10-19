import 'package:flutter_application_1/data/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  // https://api.openweathermap.org/data/2.5/weather?q=London&appid=7fb4df7fe23d52c27a57c7a008256ac2

  final String authority = 'api.openweathermap.org';
  final String path = 'data/2.5/weather';
  final String apiKey = 'effa3287e9a104cb3f1a862879b70a6a';

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appid': apiKey};
    Uri uri = Uri.https(authority, path, parameters);

    http.Response result = await http.get(uri);

    switch (result.statusCode) {
      case 200:
        Map<String, dynamic> data = json.decode(result.body);
        Weather weather = Weather.fromJson(data);
        return weather;

      default:
        throw Exception(result.reasonPhrase);
    }
  }
}
