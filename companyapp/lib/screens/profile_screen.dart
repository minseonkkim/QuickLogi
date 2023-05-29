import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/components.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:get/get.dart';


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
                            try {
                              FirebaseAuth.instance.signOut();
                              Get.offAllNamed('/SplashScreen');
                            } catch (e) {
                              print(e);
                              Get.snackbar('오류', '로그아웃 중 오류가 발생했습니다.',
                                  snackPosition: SnackPosition.TOP);
                            }
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
                          showYesOrNoDialog('정말로 회원탈퇴 하시겠습니까?', () {
                            try {
                              FirebaseAuth.instance.currentUser!.delete();
                              Get.snackbar('회원탈퇴 완료', '',
                                  snackPosition: SnackPosition.TOP);
                              FirebaseAuth.instance.signOut();
                              Get.toNamed('/SplashScreen');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'requires-recent-login') {
                                // 사용자가 최근에 로그인하지 않았으므로 재인증 필요
                                Get.snackbar('재인증 필요', '회원탈퇴를 위해 재인증이 필요합니다.',
                                    snackPosition: SnackPosition.TOP);
                                // 재인증을 위해 로그인 페이지로 이동
                                Get.toNamed('/LoginPage');
                              } else if (e.code == 'user-not-found') {
                                // 사용자를 찾을 수 없음
                                Get.snackbar('오류', '사용자를 찾을 수 없습니다.',
                                    snackPosition: SnackPosition.TOP);
                              } else {
                                // 기타 예외
                                print(e);
                              }
                            }
                          });
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
                child: Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? "",
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
                child: Text(FirebaseAuth.instance.currentUser!.email ?? "",
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
