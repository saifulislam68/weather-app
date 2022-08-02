import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  var temp;
  var tempf;
  var time;
  var location;

  int count = 0;

  void increment() {
    count++;
  }

  Future getWeather() async {
    try {
      var response = await Dio().get(
          'https://api.weatherapi.com/v1/current.json?key=68ea3b75c9c2462787e52106211203&q=location&aqi=yes');
      Map<String, dynamic> data = jsonDecode(response.toString());
      setState(() {
        temp = data['current']['temp_c'].round();

        tempf = data['current']['temp_f'].round();
        time = data['location']['localtime'].toString();
        location = data['location']['name'].toString();
      });
    } on Exception catch (e) {
      print(e.toString().toUpperCase());
    }
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    print('hello');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getWeather();
                });
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: 250,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    location.toString(),
                    style: GoogleFonts.lora(fontSize: 25, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    tempf.toString(),
                    style: GoogleFonts.lora(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                increment();
                setState(() {});
              },
              icon: const Icon(Icons.add)),
          Text('$count')
        ],
      ),
    );
  }
}
