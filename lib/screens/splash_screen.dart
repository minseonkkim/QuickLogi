import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:quick_logi/utilities/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MAINCOLOR,
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
                    'LCL 화물 물류 견적 플랫폼',
                    style: TextStyle(
                        fontFamily: 'MontserratVariable',
                        fontVariations: <FontVariation>[
                          FontVariation('wght', 600.0)
                        ],
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'QuickLogi',
                      style: TextStyle(
                          fontFamily: 'MontserratVariable',
                          fontVariations: <FontVariation>[
                            FontVariation('wght', 700.0)
                          ],
                          color: Colors.white,
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
              bottom: 30,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // 임시로 홈 화면으로 넘어가게 해둠
                      Get.toNamed('/HomeScreen');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: SUBCOLOR2, // Background color
                    ),
                    child: Text(
                      '퀵로지 시작하기',
                      style: TextStyle(
                          fontFamily: 'MontserratVariable',
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        '로그인하기',
                        style: TextStyle(
                            fontFamily: 'MontserratVariable',
                            color: Colors.white,
                            fontSize: 15),
                      ))
                ],
              ))
        ]),
      ),
    );
  }
}
