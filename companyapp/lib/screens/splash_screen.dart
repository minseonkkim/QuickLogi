import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:get/get.dart';

class LogInAndJoinButtonController extends GetxController {
  Rx<Widget> LogInAndJoinButton = (SizedBox() as Widget).obs;

  showLogInButton(Widget widget) {
    LogInAndJoinButton.value = widget;
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final controller = Get.put(LogInAndJoinButtonController());
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null ||
          FirebaseAuth.instance.currentUser!.emailVerified == false) {
        // 로그인 되어있지 않음
        controller.showLogInButton(_logInAndJoinButton());
      } else {
        // 로그인 되어있음
        Timer(Duration(milliseconds: 2000), () {
          Get.toNamed('/MainScreen');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LCL 화물 물류의 시작',
                    style: TextStyle(
                        fontFamily: 'MontserratVariable',
                        fontVariations: <FontVariation>[
                          FontVariation('wght', 600.0)
                        ],
                        color: MAINCOLOR,
                        fontSize: 20),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'QuickLogiComp',
                      style: TextStyle(
                          fontFamily: 'MontserratVariable',
                          fontVariations: <FontVariation>[
                            FontVariation('wght', 700.0)
                          ],
                          color: MAINCOLOR,
                          fontSize: 38),
                    ),
                    TextSpan(
                      text: '.',
                      style: TextStyle(
                          fontFamily: 'MontserratVariable',
                          fontVariations: <FontVariation>[
                            FontVariation('wght', 700.0)
                          ],
                          color: SUBCOLOR1,
                          fontSize: 38),
                    ),
                  ])),
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 130,
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/MainScreen');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: LIGHT, // Background color
                      ),
                      child: Text('홈 화면 보기(임시 버튼)')),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Get.toNamed('/JoinScreen');
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary: SUBCOLOR2, // Background color
                  //   ),
                  //   child: Text(
                  //     '퀵로지컴프 시작하기',
                  //     style: TextStyle(
                  //         fontFamily: 'MontserratVariable',
                  //         color: MAINCOLOR,
                  //         fontSize: 15),
                  //   ),
                  // ),
                  // TextButton(
                  //     onPressed: () {
                  //       Get.toNamed('/LoginScreen');
                  //     },
                  //     child: Text(
                  //       '로그인하기',
                  //       style: TextStyle(
                  //           fontFamily: 'MontserratVariable',
                  //           color: MAINCOLOR,
                  //           fontSize: 15),
                  //     ))
                ],
              )
            ),
            Obx(() => controller.LogInAndJoinButton.value),
          ]
        ),
      ),
    );
  }
}

class _logInAndJoinButton extends StatelessWidget {
  const _logInAndJoinButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 30,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/JoinScreen');
              },
              style: ElevatedButton.styleFrom(
                primary: SUBCOLOR2, // Background color
              ),
              child: Text(
                '퀵로지 시작하기',
                style: TextStyle(
                    fontFamily: 'MontserratVariable',
                    color: MAINCOLOR,
                    fontSize: 15),
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed('/LoginScreen');
                },
                child: Text(
                  '로그인하기',
                  style: TextStyle(
                      fontFamily: 'MontserratVariable',
                      color: MAINCOLOR,
                      fontSize: 15),
                ))
          ],
        ));
  }
}