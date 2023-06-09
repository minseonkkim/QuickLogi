import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utilities/constants.dart';

List<dynamic> notificationList = [
  RequestNotificationBox(title: '견적이 요청되었습니다.', time: '2023-06-07 20:30'),
  RespondNotificationBox(title: '견적 요청이 수락되었습니다.', time: '2023-06-07 23:20'),
  RequestNotificationBox(title: '견적이 요청되었습니다.', time: '2023-06-07 20:30')
];

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
        // Container(
        //   color: LIGHT,
        //   width: double.infinity,
        //   height: 50,
        // ),
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
                    fontFamily: 'Pretendard', color: GREY1, fontSize: 16),
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
                color: LIGHT,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '퀵로지 운송알림',
                      style: TextStyle(
                          fontFamily: 'PretendardBold',
                          color: Colors.black,
                          fontSize: 23),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: notificationList.length,
                        itemBuilder: (context, index) {
                          return notificationList[index];
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}

class RequestNotificationBox extends StatelessWidget {
  String title, time;
  RequestNotificationBox({required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'PretendardBold',
                color: Colors.black,
                fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white60, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(children: [
                  Container(
                      margin: const EdgeInsets.all(12),
                      height: 60,
                      child: Image.asset('assets/images/place_arrow.png')),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '부산(KRPUS)',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.black,
                              fontSize: 15.5),
                        ),
                        Text(
                          'Penglai(CNPLA)',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.black,
                              fontSize: 15.5),
                        )
                      ],
                    ),
                  )
                ]),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '운송일시',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  color: Colors.grey[700],
                                  fontSize: 13.5),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '2023.06.10 (22:00)',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  color: Colors.black,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          children: [
                            Text(
                              '화물정보',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  color: Colors.grey[700],
                                  fontSize: 13.5),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '일반화물 10개 외 1건',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  color: Colors.black,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            time,
            style: TextStyle(
                fontFamily: 'Pretendard',
                color: Colors.grey[400],
                fontSize: 12),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class RespondNotificationBox extends StatelessWidget {
  String title, time;
  RespondNotificationBox({required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'PretendardBold',
                color: Colors.black,
                fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white60, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(children: [
                  Container(
                      margin: const EdgeInsets.all(12),
                      height: 60,
                      child: Image.asset('assets/images/place_arrow.png')),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '부산(KRPUS)',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.black,
                              fontSize: 15.5),
                        ),
                        Text(
                          'Penglai(CNPLA)',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.black,
                              fontSize: 15.5),
                        )
                      ],
                    ),
                  )
                ]),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '운송일시',
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Colors.grey[700],
                                      fontSize: 13.5),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '2023.06.10 (22:00)',
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Colors.black,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              children: [
                                Text(
                                  '화물정보',
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Colors.grey[700],
                                      fontSize: 13.5),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '일반화물 10개 외 1건',
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Colors.black,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '수락여부',
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Colors.grey[700],
                                      fontSize: 13.5),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '수락',
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Colors.black,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              children: [
                                Text(
                                  '회사명',
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Colors.grey[700],
                                      fontSize: 13.5),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '블라블라',
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Colors.black,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            time,
            style: TextStyle(
                fontFamily: 'Pretendard',
                color: Colors.grey[400],
                fontSize: 12),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
