import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'UI/_module.dart';

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
        )
      ],
    );
  }
}
