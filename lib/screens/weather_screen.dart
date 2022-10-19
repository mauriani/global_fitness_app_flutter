import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/http_helper.dart';

import '../data/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WatherScreenState();
}

class _WatherScreenState extends State<WeatherScreen> {
  final TextEditingController txtPlace = TextEditingController();

  Weather result = Weather('', '', 0, 0, 0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                  controller: txtPlace,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Informe a cidade',
                      suffixIcon: IconButton(
                          onPressed: getData, icon: const Icon(Icons.search)))),
            ),
            weatherRow('Place:', result.name),
            weatherRow('Description:', result.description),
            weatherRow('Temperature:', result.temperature.toStringAsFixed(2)),
            weatherRow('Perceived:', result.perceived.toStringAsFixed(2)),
            weatherRow('Pressure:', result.pressure.toString()),
            weatherRow('humidity:', result.humidity.toString()),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    HttpHelper helper = HttpHelper();
    result = await helper.getWeather(txtPlace.text);

    setState(() {});
  }

  Widget weatherRow(String label, String value) {
    Widget row = Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).hintColor,
                )),
          ),
          Expanded(
            flex: 4,
            child: Text(value,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                )),
          )
        ],
      ),
    );
    return row;
  }
}
