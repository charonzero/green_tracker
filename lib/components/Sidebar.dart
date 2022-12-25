// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:greentracker/constants.dart';
import 'package:greentracker/models/login.dart';
import 'package:greentracker/router.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Container(
              margin: EdgeInsets.only(top: size.height * .0025),
              height: size.height * 0.07,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Colors.red.shade400, //change text color of button
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey.shade100,
                        width: 0.002,
                      ),
                    ),
                    elevation: .5,
                  ),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: size.height * 0.0225,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
      child: const Text("Changed my mind."),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
      child: const Text("Yes."),
      onPressed: () async {
        await userLogout();
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => const RouterScreen(
                      title: 'Green Tracker',
                    )),
            (route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Do you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
