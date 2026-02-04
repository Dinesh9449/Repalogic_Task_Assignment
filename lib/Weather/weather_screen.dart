import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController cityController = TextEditingController();
  List forecastList = [];
  bool loading = false;
  String error = '';

  final String apiKey = '24edde2cd1d3dc66f6cb1ad83553eae0';

  Future<void> fetchWeather(String city) async {
    setState(() {
      loading = true;
      error = '';
    });

    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          forecastList = data['list'];
          loading = false;
        });
      } else {
        setState(() {
          error = 'City not found';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Something went wrong';
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    cityController.text = 'Chennai';
    fetchWeather('Chennai');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    fetchWeather(cityController.text);
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: fetchWeather,
            ),
          ),

          if (loading) const CircularProgressIndicator(),

          if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(error, style: const TextStyle(color: Colors.red)),
            ),

          Expanded(
            child: ListView.builder(
              itemCount: forecastList.length,
              itemBuilder: (context, index) {
                final item = forecastList[index];
                return ListTile(
                  leading: const Icon(Icons.cloud),
                  title: Text('${item['main']['temp']} °C'),
                  subtitle: Text(item['dt_txt']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
