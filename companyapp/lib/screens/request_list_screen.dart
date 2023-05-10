import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:get/get.dart';


class RequestListController extends GetxController {
  RxBool total = false.obs;
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
              color: SUBCOLOR1,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                Obx(() => controller.total.value
                    ? _TotalList()
                    : controller.ing.value
                        ? _IngList()
                        : _CompletedList()),
              ]),
            ),
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
      child: Container(alignment: Alignment.center, child: Text('전체')),
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
