import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: sized_box_for_whitespace
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
              // child: Image.asset(
              //   "assets/images/background2.png",
              //   height: size.height,
              //   fit: BoxFit.fitHeight,
              // ),
              child: Container(color: Colors.white)),
          child
        ],
      ),
    );
  }
}
