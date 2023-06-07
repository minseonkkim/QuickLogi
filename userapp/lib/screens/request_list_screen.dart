import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:quick_logi/utilities/constants.dart';

class RequestListController extends GetxController {
  RxBool total = true.obs;
  RxBool ing = false.obs;
  RxBool completed = false.obs;
}

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestListController());
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
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: '견적 요청목록',
              style: TextStyle(
                  fontFamily: 'PretendardBold',
                  color: Colors.black,
                  fontSize: 27),
            ),
            TextSpan(
              text: '.',
              style: TextStyle(
                  fontFamily: 'PretendardBold', color: SUBCOLOR1, fontSize: 27),
            ),
          ])),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(13, 18, 13, 18),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
              color: SUBCOLOR1,
            ),
            child: Column(children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.total.value = true;
                      controller.ing.value = false;
                      controller.completed.value = false;
                    },
                    child: Obx(
                      () => Text(
                        '전체',
                        style: TextStyle(
                            fontFamily: 'PretendardBold',
                            color: controller.total.value
                                ? Colors.white
                                : Colors.white30,
                            fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.total.value = false;
                      controller.ing.value = true;
                      controller.completed.value = false;
                    },
                    child: Obx(
                      () => Text(
                        '매칭중',
                        style: TextStyle(
                            fontFamily: 'PretendardBold',
                            color: controller.ing.value
                                ? Colors.white
                                : Colors.white30,
                            fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.total.value = false;
                      controller.ing.value = false;
                      controller.completed.value = true;
                    },
                    child: Obx(
                      () => Text(
                        '매칭완료',
                        style: TextStyle(
                            fontFamily: 'PretendardBold',
                            color: controller.completed.value
                                ? Colors.white
                                : Colors.white30,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Obx(() => controller.total.value
                  ? _TotalList()
                  : controller.ing.value
                      ? _IngList()
                      : _CompletedList()),
            ]),
          ),
        ),
      ]),
    );
  }
}

class _TotalList extends StatelessWidget {
  const _TotalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [_RequestBox()]),
    );
  }
}

class _IngList extends StatelessWidget {
  const _IngList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(alignment: Alignment.center, child: Text('매칭중')),
    );
    ;
  }
}

class _CompletedList extends StatelessWidget {
  const _CompletedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(alignment: Alignment.center, child: Text('매칭완료')),
    );
    ;
  }
}

class _RequestBox extends StatelessWidget {
  const _RequestBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white30, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          '매칭 중',
          style:
              TextStyle(fontFamily: 'PretendardBold', color: RED, fontSize: 20),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '출발지: 부산(PUS) / 도착지: 텐진시(TSN)',
          style: TextStyle(
              fontFamily: 'Pretendard', color: Colors.black54, fontSize: 16),
        ),
        Text(
          '출고 예정일: 2023.06.20 13:30',
          style: TextStyle(
              fontFamily: 'Pretendard', color: Colors.black54, fontSize: 16),
        ),
        Text(
          '화물 정보: 일반화물 DRY 10개 외 1건',
          style: TextStyle(
              fontFamily: 'Pretendard', color: Colors.black54, fontSize: 16),
        ),
      ]),
    );
  }
}
