import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_utils/keyboard_aware/keyboard_aware.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:greentracker/components/RoundButton.dart';
import 'package:greentracker/components/RoundInputField.dart';
import 'package:greentracker/components/RoundPasswordField.dart';
import 'package:greentracker/constants.dart';
import 'package:greentracker/models/login.dart';
import 'package:greentracker/components/background.dart';
import 'package:greentracker/pages/home_container.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void initState() {
    super.initState();
  }

  late String username = 'mawgyi', password = 'Charon22@';
  late bool isLoading = false;
  late String errorText = '';
  setLoading(bool state) => setState(() => isLoading = state);
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // adjust window size for browser login
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Background(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              KeyboardAware(
                builder: (context, keyboardConfig) {
                  if (!keyboardConfig.isKeyboardOpen) {
                    return Image.asset("assets/images/logo.png",
                        height: size.height * 0.3);
                  } else {
                    return Container();
                  }
                },
              ),
              Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                    fontSize: size.height * 0.03),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    RoundedInputField(
                      hintText: "Username",
                      icon: Icons.verified_user_rounded,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      validatorText: 'Please enter your username',
                      onChanged: (value) {
                        username = value;
                      },
                    ),
                    RoundedPasswordField(
                      hintText: "Password",
                      icon: Icons.password,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                        height: errorText.isNotEmpty ? size.height * 0.05 : 0,
                        child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 300),
                            width: size.width * 0.8 - 40,
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow
                                  .fade, // TextOverflow.clip // TextOverflow.fade
                              text: TextSpan(
                                text: errorText,
                                style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                            ))),
                    RoundButton(
                        text: Text(isLoading != true ? "Login" : 'Loading...'),
                        onpress: () async {
                          if (isLoading != true) {
                            loginUsers();
                          }
                        }),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  Future<void> loginUsers() async {
    if (_formKey.currentState!.validate()) {
      setLoading(true);
      showScaffold(
        "Loggin in.",
        Colors.green.shade300,
      );
      try {
        dynamic res = await userLogin(username, password);
        await Future.delayed(const Duration(seconds: 2), () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        });
        if (!mounted) return;
        if (res == 200) {
          onSuccess();
        } else if (res == 401) {
          showScaffold(
            "Error: Wrong credentials provided.",
            Colors.red.shade300,
          );
        } else if (res == -1) {
          showScaffold(
            "Error: Connection Error. Please check your internet.",
            Colors.red.shade300,
          );
        } else {
          showScaffold(
            "Error",
            Colors.red.shade300,
          );
        }
      } catch (_) {
        showScaffold(
          "Error",
          Colors.red.shade300,
        );
      }
      hideScaffold();
    }
  }

  void hideScaffold() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      setLoading(false);
    });
  }

  void showScaffold(String status, Color color) async {
    await Future.delayed(const Duration(seconds: 0));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(status),
      backgroundColor: color,
      duration: const Duration(seconds: 60),
    ));
  }

  void onSuccess() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const HomeContainer()),
        (Route<dynamic> route) => route is HomeContainer);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
