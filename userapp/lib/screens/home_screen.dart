import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:quick_logi/utilities/global.dart';

import '../utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? myDeviceToken = '';
  void getMyDeviceToken() async {
    myDeviceToken = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $myDeviceToken");
  }

  @override
  void initState() {
    getMyDeviceToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: 'QuickLogi',
              style: TextStyle(
                  fontFamily: 'MontserratVariable',
                  fontVariations: <FontVariation>[FontVariation('wght', 700.0)],
                  color: MAINCOLOR,
                  fontSize: 38),
            ),
            TextSpan(
              text: '.',
              style: TextStyle(
                  fontFamily: 'MontserratVariable',
                  fontVariations: <FontVariation>[FontVariation('wght', 700.0)],
                  color: SUBCOLOR1,
                  fontSize: 38),
            ),
          ])),
        ),
        Container(
          color: LIGHT,
          width: double.infinity,
          height: 50,
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text:
                      '안녕하세요 ${FirebaseAuth.instance.currentUser!.displayName ?? ""}님',
                  style: TextStyle(
                      fontFamily: 'PretendardBold',
                      color: Colors.black,
                      fontSize: 30),
                ),
                TextSpan(
                  text: '.',
                  style: TextStyle(
                      fontFamily: 'PretendardBold',
                      color: SUBCOLOR1,
                      fontSize: 30),
                ),
              ])),
              SizedBox(
                height: 5,
              ),
              Text(
                '운송 정보를 선택하고 지금 바로 견적을 요청해보세요!',
                style: TextStyle(
                    fontFamily: 'Pretendard', color: GREY1, fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/RequestInfoSelectScreen');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MAINCOLOR,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '견적 요청하기',
                            style: TextStyle(
                                fontFamily: 'PretendardBold',
                                color: Colors.white,
                                fontSize: 22),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 28,
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: GREY2,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 13, 10, 13),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '퀵로지 운송알림',
                      style: TextStyle(
                          fontFamily: 'PretendardBold',
                          color: Colors.black,
                          fontSize: 18),
                    ),
                    // ElevatedButton(
                    //   child: Text(''),
                    //   onPressed: () {
                    //     sendNotificationToDevice(
                    //         deviceToken: myDeviceToken!,
                    //         title: '테스트알림',
                    //         content: '내용',
                    //         data: {
                    //           'contents_idx': 1,
                    //           'test_parameter1': '테스트1',
                    //         });
                    //   },
                    // )
                  
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}
