import 'dart:convert';
import 'package:api/Api/WeatherModel.dart';
import 'package:api/service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Weathers extends StatefulWidget {
  const Weathers({super.key});

  @override
  State<Weathers> createState() => _WeathersState();
}

class _WeathersState extends State<Weathers> {
  String apiKey = "b3241b166a34277e9ff8b825b21d91c3";
  // Position? currentPosition;
  late WeatherData weatherInfo;
  bool isLoading = false;
  myWeather() {
    isLoading = false;
    WeatherServices().fetchWeather().then((value) {
      setState(() {
        weatherInfo = value;
        isLoading = true;
      });
    });
  }

  @override
  void initState() {
    weatherInfo = WeatherData(
      name: '',
      temperature: Temperature(current: 0.0),
      humidity: 0,
      wind: Wind(speed: 0.0),
      maxTemperature: 0,
      minTemperature: 0,
      pressure: 0,
      seaLevel: 0,
      weather: [],
    );
    myWeather();
    super.initState();
  }
  // late double latitude;
  // late double longitude;
  //
  // Future<Position> _getCurrentPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   return await Geolocator.getCurrentPosition();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: isLoading
                ? WeatherDetail(
              weather: weatherInfo,
            )
                : const CircularProgressIndicator(color: Colors.white,),
          ),
        ],
      )
    );
  }
}
class WeatherDetail extends StatelessWidget {
  final WeatherData weather;

  const WeatherDetail({
    super.key,
    required this.weather,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weather.name.toString())
      ],
    );
  }
}
