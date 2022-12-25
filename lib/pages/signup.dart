// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:keyboard_utils/keyboard_aware/keyboard_aware.dart';
// import 'package:keyboard_utils/keyboard_utils.dart';
// import 'package:greentracker/components/RoundButton.dart';
// import 'package:greentracker/components/RoundInputField.dart';
// import 'package:greentracker/components/RoundPasswordField.dart';
// import 'package:greentracker/components/RoundPasswordFieldRegister.dart';
// import 'package:greentracker/constants.dart';
// import 'package:greentracker/models/login.dart';
// import 'package:greentracker/components/background.dart';
// import 'package:greentracker/pages/home_container.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   String username = '',
//       password = '',
//       email = '',
//       phone = '',
//       confirmpassword = '';
//   late bool isLoading = false;
//   late String errorText = '';
//   setLoading(bool state) => setState(() => isLoading = state);
//   static final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     // adjust window size for browser login
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Background(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 KeyboardAware(
//                   builder: (context, keyboardConfig) {
//                     if (!keyboardConfig.isKeyboardOpen) {
//                       return Image.asset("assets/images/logo.png",
//                           height: size.height * 0.15);
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//                 Text(
//                   "Registration Form",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: kPrimaryColor,
//                       fontSize: size.height * 0.03),
//                 ),
//                 Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Column(
//                           children: [
//                             RoundedInputField(
//                               hintText: "Name",
//                               keyboardType: TextInputType.name,
//                               icon: Icons.verified_user,
//                               validatorText: 'Please enter your name.',
//                               onChanged: (value) {
//                                 username = value;
//                               },
//                             ),
//                             RoundedInputField(
//                               hintText: "Phone Number",
//                               keyboardType: TextInputType.phone,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly
//                               ],
//                               icon: Icons.phone,
//                               validatorText: 'Please enter your phone number.',
//                               onChanged: (value) {
//                                 phone = value;
//                               },
//                             ),
//                             RoundedInputField(
//                               hintText: "Email",
//                               icon: Icons.alternate_email_outlined,
//                               keyboardType: TextInputType.emailAddress,
//                               validatorText: 'Please enter your email.',
//                               onChanged: (value) {
//                                 email = value;
//                               },
//                             ),
//                             RoundedPasswordFieldRegister(
//                               hintText: "Password",
//                               passwordvalue: password,
//                               icon: Icons.password,
//                               validatorText: 'Please enter your password.',
//                               onChanged: (value) {
//                                 password = value;
//                               },
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                             height:
//                                 errorText.isNotEmpty ? size.height * 0.05 : 0,
//                             child: Container(
//                                 constraints: const BoxConstraints(
//                                     minWidth: 100, maxWidth: 300),
//                                 width: size.width * 0.8 - 40,
//                                 child: RichText(
//                                   maxLines: 2,
//                                   overflow: TextOverflow
//                                       .fade, // TextOverflow.clip // TextOverflow.fade
//                                   text: TextSpan(
//                                     text: errorText,
//                                     style: const TextStyle(
//                                         color: Colors.redAccent,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ))),
//                         RoundButton(
//                             text: Text(
//                                 isLoading != true ? "Register" : 'Loading...'),
//                             onpress: () async {
//                               if (isLoading != true) {
//                                 RegisterUsers();
//                               }
//                             }),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ));
//   }

//   Future<void> RegisterUsers() async {
//     if (_formKey.currentState!.validate()) {
//       setLoading(true);
//       showScaffold(
//         "Loggin in.",
//         Colors.green.shade300,
//       );
//       try {
//         dynamic res = await userSignup(username, password, email, phone);
//         await Future.delayed(const Duration(seconds: 2), () {
//           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//         });
//         if (!mounted) return;
//         if (res == 200) {
//           onSuccess();
//         } else if (res == 401) {
//           showScaffold(
//             "Error: Wrong credentials provided.",
//             Colors.red.shade300,
//           );
//         } else if (res == -1) {
//           showScaffold(
//             "Error: Connection Error. Please check your internet.",
//             Colors.red.shade300,
//           );
//         } else {
//           showScaffold(
//             "Error",
//             Colors.red.shade300,
//           );
//         }
//       } catch (_) {
//         showScaffold(
//           "Error",
//           Colors.red.shade300,
//         );
//       }
//       hideScaffold();
//     }
//   }

//   void hideScaffold() async {
//     await Future.delayed(const Duration(seconds: 2), () {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       setLoading(false);
//     });
//   }

//   void showScaffold(String status, Color color) async {
//     await Future.delayed(const Duration(seconds: 0));
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(status),
//       backgroundColor: color,
//       duration: const Duration(seconds: 60),
//     ));
//   }

//   void onSuccess() async {
//     await Future.delayed(const Duration(seconds: 1));

//     if (!mounted) return;
//     Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//             builder: (BuildContext context) => const HomeContainer()),
//         (Route<dynamic> route) => route is HomeContainer);
//   }
// }
