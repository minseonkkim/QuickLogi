import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/screens/container_result_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:get/get.dart';


// bottomNavigationBar binding
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ContainerResultScreen(), // 여기 수정
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Icon(
                      Icons.home_filled,
                      color: MAINCOLOR,
                    )
                  : Icon(Icons.home_outlined, color: Colors.black),
              label: '홈'),
          BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? Icon(
                      Icons.dashboard_customize_outlined,
                      color: MAINCOLOR,
                    )
                  : Icon(
                      Icons.dashboard_customize_outlined,
                      color: Colors.black,
                    ),
              label: '배치해보기'),
          BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? Icon(Icons.person, color: MAINCOLOR)
                  : Icon(
                      Icons.person_outline,
                      color: Colors.black,
                    ),
              label: '프로필')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MAINCOLOR,
        onTap: _onItemTapped,
      ),
    );
  }
}
