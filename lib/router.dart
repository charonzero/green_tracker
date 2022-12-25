import 'package:flutter/material.dart';
import 'package:greentracker/pages/home_container.dart';
import 'package:greentracker/pages/welcome_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class RouterScreen extends StatefulWidget {
  final String title;

  const RouterScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  @override
  void initState() {
    welcomeRoute();
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> welcomeRoute() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var data = prefs.getString('userid');
      if (data != null) {
        Future.delayed(
            const Duration(seconds: 3),
            () => {
                  if (mounted)
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeContainer()))
                    }
                });
      } else {
        Future.delayed(
            const Duration(seconds: 3),
            () => {
                  if (mounted)
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()))
                    }
                });
      }
    } catch (err) {
      Future.delayed(
          const Duration(seconds: 3),
          () => {
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()))
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SizedBox(
                height: size.height * 0.3,
                child: Image.asset("assets/images/logo.png",
                    width: size.width * 0.75, alignment: Alignment.center))));
  }
}
