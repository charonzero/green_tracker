// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greentracker/constants.dart';
import 'package:greentracker/pages/home_container.dart';
import 'package:greentracker/pages/welcome_screen.dart';
import 'package:greentracker/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MnsApp());
}

class MnsApp extends StatelessWidget {
  const MnsApp({Key? key}) : super(key: key);
  static const String _title = 'Green Tracker';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          surfaceTintColor: kPrimaryColor,
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        // appBarTheme: const AppBarTheme(
        //   color: kPrimaryColor,
        // ),
        // fontFamily: 'Pyidaungsu',
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const GreenTracker(),
    );
  }
}

class GreenTracker extends StatefulWidget {
  const GreenTracker({super.key});

  @override
  State<GreenTracker> createState() => _GreenTrackerState();
}

class _GreenTrackerState extends State<GreenTracker> {
  final Location _location = Location();

  @override
  void initState() {
    initSocket();
    super.initState();
  }

  Future<void> initSocket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    if (prefs.getString('userid') != null) {
      IO.Socket socket = IO.io(('http://172.23.70.152:3000'), <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();
      // socket.on(
      //     'connecting', (data) => print('Socket is trying so hard to connect'));
      // socket.onConnect((_) {
      //   if (socket.connected) {
      //     print('socket connected');
      //   }
      // });
      // socket.onConnectError((err) => print(err));
      // socket.onError((err) => print(err));
      Location location = new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _location.onLocationChanged.distinct().listen((l) {
        var coords = {"userid": userid, "lat": l.latitude, "lng": l.longitude};
        socket.emit('position-change', jsonEncode(coords));
      });
      _location.changeSettings(accuracy: LocationAccuracy.low, interval: 5000);
    }
  }

  Future<String> autoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getString('userid') != null ? true : false;
    if (loggedIn == true) {
      return 'home';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: autoLogin(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'home') {
              return const HomeContainer();
            } else {
              return const WelcomeScreen();
            }
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}
