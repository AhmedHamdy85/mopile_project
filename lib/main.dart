import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mopile_project/calcolate_distance.dart';
import 'package:mopile_project/getLocation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        if (prevousLocation != null) {
          setState(() {
            distance = Distance.distanceBetween(
                prevousLocation!.latitude,
                prevousLocation!.longitude,
                currentLocation!.latitude,
                currentLocation!.longitude);
            speed = distance / 30;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avarege Speed'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)]),
                child:
                    Center(child: Text('Speed: ${speed.toStringAsFixed(2)}'))),
          ),
        ],
      ),
    );
  }
}
