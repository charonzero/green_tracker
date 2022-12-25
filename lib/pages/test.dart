// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ProfileScreen(),
//     );
//   }
// }

// const darkColor = Color(0xFF49535C);

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var montserrat = TextStyle(
//       fontSize: 12,
//     );
//     return Material(
//       child: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.blue,
//         ),
//         child: 
//       ),
//     );
//   }

//   TextStyle buildMontserrat(
//     Color color, {
//     FontWeight fontWeight = FontWeight.normal,
//   }) {
//     return TextStyle(
//       fontSize: 18,
//       color: color,
//       fontWeight: fontWeight,
//     );
//   }
// }

// class AvatarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       ..lineTo(0, size.height)
//       ..lineTo(8, size.height)
//       ..arcToPoint(Offset(114, size.height), radius: Radius.circular(1))
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width, 0)
//       ..close();
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
