import 'package:flutter/material.dart';
import 'package:greentracker/components/RoundButton.dart';
import 'package:greentracker/components/background.dart';

import './login.dart';
import './signup.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", height: size.height * 0.3),
            SizedBox(
              height: size.height * .04,
            ),
            // Image.asset("assets/icons/free.png", height: size.height * 0.3),
            SizedBox(
              height: size.height * .04,
            ),
            RoundButton(
                text: const Text("Login"),
                onpress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Login();
                  }));
                }),
            SizedBox(
              height: size.height * .01,
            ),
            // RoundButton(
            //     text: const Text("Sign Up"),
            //     color: Colors.black,
            //     onpress: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) {
            //         return const SignUp();
            //       }));
            //     }),
          ],
        ),
      ),
    );
  }
}
