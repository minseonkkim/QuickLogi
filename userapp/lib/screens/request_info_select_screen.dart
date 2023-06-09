import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:quick_logi/screens/home_screen.dart';
import 'package:quick_logi/utilities/notification.dart';

import '../utilities/components.dart';
import '../utilities/constants.dart';

class RequestInfoSelectScreen extends StatefulWidget {
  const RequestInfoSelectScreen({super.key});

  @override
  State<RequestInfoSelectScreen> createState() =>
      _RequestInfoSelectScreenState();
}

class _RequestInfoSelectScreenState extends State<RequestInfoSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackTopBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '퀵로지 견적 요청하기',
              style: TextStyle(
                  fontFamily: 'PretendardBold',
                  color: Colors.black,
                  fontSize: 30),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '원하시는 항목부터 입력해주세요.',
              style: TextStyle(
                  fontFamily: 'Pretendard', color: GREY1, fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            SelectButton(
              icon: Icons.place_outlined,
              text: '출·도착지',
              selectedInfo: 'selectedPlace',
              route: '/PlaceSelectScreen',
            ),
            SelectButton(
              icon: Icons.date_range_rounded,
              text: '출고 예정일',
              selectedInfo: 'selectedDate',
              route: '/DateSelectScreen',
            ),
            SelectButton(
              icon: Icons.add_box,
              text: '화물 정보',
              selectedInfo: '',
              route: '/FreightSelectScreen',
            ),
          ],
        ),
      )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            notificationList.insert(
                0,
                RequestNotificationBox(
                  title: '견적이 요청되었습니다.',
                  time: DateTime.now().toString().substring(0, 16),
                  start: '부산(KRPUS)',
                  end: 'Penglai(CNPLA)',
                  date: '2023.08.02 (20:00)',
                  freight: '일반화물 10개 외 1건',
                ));
            showNotification('견적 요청 완료', '작성하신 견적이 요청되었습니다.');
            Get.toNamed('/MainScreen');
          },
          style: ElevatedButton.styleFrom(
            primary: MAINCOLOR,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            '요청하기',
            style: TextStyle(
                fontFamily: 'Pretendard', color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class SelectButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final String selectedInfo;
  final String route;

  SelectButton(
      {required this.icon,
      required this.text,
      required this.selectedInfo,
      required this.route});

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  var value = null;
  @override
  Widget build(BuildContext context) {
    final String selectedInfo = widget.selectedInfo;
    return GestureDetector(
      onTap: () async {
        value = await Get.toNamed(widget.route);
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 12, 5, 12),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Icon(
              widget.icon,
              size: 30,
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                      fontFamily: 'PretendardBold',
                      color: Colors.black,
                      fontSize: 23),
                ),
                value != null
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                        child: Text(value),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
          ),
        ]),
      ),
    );
  }
}
