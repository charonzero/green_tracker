import 'package:flutter/material.dart';
import 'package:greentracker/components/Sidebar.dart';
import 'package:greentracker/constants.dart';

import 'package:greentracker/pages/home_screen.dart';
import 'package:greentracker/pages/profile_screen.dart';
import 'package:greentracker/pages/current_route_setting.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int _selectedIndex = 0;

  final List<Widget> _widget = <Widget>[
    const HomeScreen(),
    const CurrentRouteSettingScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Green Tracker'),
              backgroundColor: kPrimaryColor,
            ),
            // appBar: null,
            // drawer: const SideBar(),
            body: Center(
              child: _widget.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: BottomNavigationBar(
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.menu),
                        label: 'Menu',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: kPrimaryColor,
                    onTap: _onItemTapped,
                  ),
                ))));
  }
}
