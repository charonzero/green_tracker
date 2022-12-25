import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greentracker/constants.dart';
import 'package:greentracker/models/login.dart';
import 'package:greentracker/router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          showAlertDialog(context);
        },
        child: const Icon(Icons.logout_outlined),
      ),
      body: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserDataAPI userDataAPI = snapshot.data as UserDataAPI;
                if (userDataAPI.status == 200) {
                  UserData userData = userDataAPI.userData as UserData;
                  return Container(
                    width: double.infinity,
                    height: size.height,
                    // constraints: BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 180,
                          child: Stack(
                            children: [
                              ClipPath(
                                clipper: AvatarClipper(),
                                child: Container(
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: kPrimaryColor,
                                    // borderRadius: BorderRadius.only(
                                    //   topRight: Radius.circular(20),
                                    //   topLeft: Radius.circular(20),
                                    // ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 11,
                                top: 60,
                                child: Row(
                                  children: [
                                    // const CircleAvatar(
                                    //   radius: 50,
                                    //   backgroundImage: NetworkImage(
                                    //       "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/22/22a4f44d8c8f1451f0eaa765e80b698bab8dd826_full.jpg"),
                                    // ),
                                    const CircleAvatar(
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                            'assets/images/logo.png')),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userData.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Color(0xFFFFFFFF),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 2.5),
                                        Text(
                                          "@${userData.username}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFFFFFFFF),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 25),
                                        Text(
                                          "Legendary ${userData.role}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 8)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              // border: Border.all(color: kPrimaryColor),
                              // borderRadius: BorderRadius.only(
                              //   topRight: Radius.circular(20),
                              //   topLeft: Radius.circular(20),
                              // ),
                              ),
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: const [
                                  Text(
                                    "620",
                                  ),
                                  Text(
                                    "Total Waypoints",
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Color(0xFF9A9A9A),
                                ),
                              ),
                              Column(
                                children: const [
                                  Text(
                                    "17",
                                  ),
                                  Text(
                                    "Sent",
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Color(0xFF9A9A9A),
                                ),
                              ),
                              Column(
                                children: const [
                                  Text(
                                    "163 miles",
                                  ),
                                  Text(
                                    "Total travelled",
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 30,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "Email: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Phone: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Address: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.email,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    userData.phone,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    userData.address,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(),

                        // const SizedBox(height: 20),
                        const Spacer(),
                        // const SizedBox(height: 8)
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Error please relogin.'),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
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
        Navigator.of(context, rootNavigator: true).pop();
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height)
      ..arcToPoint(Offset(114, size.height), radius: const Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
