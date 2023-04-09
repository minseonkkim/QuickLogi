import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_logi/screens/login_screen.dart';
import 'package:quick_logi/screens/request_info_select/date_select_screen.dart';
import 'package:quick_logi/screens/home_screen.dart';
import 'package:quick_logi/screens/request_info_select/freight_select_screen.dart';
import 'package:quick_logi/screens/request_info_select/place_select_screen.dart';
import 'package:quick_logi/screens/request_info_select_screen.dart';
import 'package:quick_logi/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickLogi',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/SplashScreen',
      getPages: [
        GetPage(name: '/HomeScreen', page: () => HomeScreen()),
        GetPage(
          name: '/SplashScreen',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/RequestInfoSelectScreen',
          page: () => RequestInfoSelectScreen(),
        ),
        GetPage(
          name: '/PlaceSelectScreen',
          page: () => PlaceSelectScreen(),
        ),
        GetPage(
          name: '/DateSelectScreen',
          page: () => DateSelectScreen(),
        ),
        GetPage(
          name: '/FreightSelectScreen',
          page: () => FreightSelectScreen(),
        ),
        GetPage(
          name: '/LoginScreen',
          page: () => LoginScreen(),
        ),
      ],
    );
  }
}
