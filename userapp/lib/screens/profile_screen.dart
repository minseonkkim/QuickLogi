import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:quick_logi/utilities/components.dart';
import 'package:quick_logi/utilities/constants.dart';

class ProfileScreen extends StatelessWidget {
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: '내 계정',
                      style: TextStyle(
                          fontFamily: 'PretendardBold',
                          color: Colors.black,
                          fontSize: 27),
                    ),
                    TextSpan(
                      text: '.',
                      style: TextStyle(
                          fontFamily: 'PretendardBold',
                          color: SUBCOLOR1,
                          fontSize: 27),
                    ),
                  ])),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showYesOrNoDialog('로그아웃 하시겠습니까?', () {
                            FirebaseAuth.instance.signOut();
                            Get.back();
                          });
                        },
                        child: Text(
                          '로그아웃',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Pretendard',
                              color: GREY1,
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          showYesOrNoDialog('정말로 회원탈퇴 하시겠습니까?', () {});
                        },
                        child: Text(
                          '회원탈퇴',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Pretendard',
                              color: GREY1,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text('이름',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.black,
                      fontSize: 18)),
              SizedBox(
                height: 7,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: GREY2,
                    border: Border.all(
                      width: 1,
                      color: GREY1,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Text('홍길동',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 18)),
              ),
              SizedBox(
                height: 15,
              ),
              Text('이메일',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.black,
                      fontSize: 18)),
              SizedBox(
                height: 7,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: GREY2,
                    border: Border.all(
                      width: 1,
                      color: GREY1,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Text('minsun9856@gmail.com',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 18)),
              ),
              SizedBox(
                height: 15,
              ),
              Text('연락처',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.black,
                      fontSize: 18)),
              SizedBox(
                height: 7,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: GREY2,
                    border: Border.all(
                      width: 1,
                      color: GREY1,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Text('010XXXXXXXX',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 18)),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
