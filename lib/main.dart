import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mopile_project/getLocation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const AvaregSpeed(),
    );
  }
}

class AvaregSpeed extends StatefulWidget {
  const AvaregSpeed({super.key});

  @override
  State<AvaregSpeed> createState() => _AvaregSpeedState();
}

class _AvaregSpeedState extends State<AvaregSpeed> {
  Position? currentLocation;
  Position? prevousLocation;
  double distance = 0;
  double speed = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Location.getUserLocation().then((value) {
      currentLocation = value;
    });
    startTimar();
  }

  void startTimar() {
    Timer.periodic(Duration(seconds: 30), (timer) {
      Location.getUserLocation().then((value) {
        prevousLocation = currentLocation;
        currentLocation = value;
        setState(() {
          distance = Geolocator.distanceBetween(
              prevousLocation!.latitude,
              prevousLocation!.longitude,
              currentLocation!.latitude,
              currentLocation!.longitude);
          speed = distance / 30;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('distance is $distance'),
          Text('speed is $speed'),
          Text('curentlocation is $currentLocation'),
          Text('previoslocation is $prevousLocation'),
        ],
      ),
    );
  }
}
