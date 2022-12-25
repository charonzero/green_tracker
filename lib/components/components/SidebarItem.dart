// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:greentracker/constants.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    Key? key,
    required this.size,
    required this.name,
    required this.route,
  }) : super(key: key);

  final Size size;
  final String name;
  final Widget route;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * .0025),
      height: size.height * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: kLightDark,
          backgroundColor: Colors.grey.shade100, //change text color of button
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey.shade100,
              width: 0.002,
            ),
          ),
          elevation: .5,
        ),
        onPressed: () {
          Navigator.of(context).push(_route(route));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            const Spacer(),
            Icon(Icons.chevron_right_outlined,
                size: size.height * 0.03, color: kLightDark)
          ],
        ),
      ),
    );
  }
}

Route _route(route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
