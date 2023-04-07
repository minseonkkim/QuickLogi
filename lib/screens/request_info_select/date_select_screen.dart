import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:quick_logi/utilities/components.dart';
import 'package:quick_logi/utilities/constants.dart';

class DateSelectScreen extends StatefulWidget {
  const DateSelectScreen({super.key});

  @override
  State<DateSelectScreen> createState() => _DateSelectScreenState();
}

class _DateSelectScreenState extends State<DateSelectScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackTopBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '출고 예정일',
                    style: TextStyle(
                        fontFamily: 'PretendardBold',
                        color: Colors.black,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '언제 보낼까요?',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: GREY2, shape: BoxShape.circle),
                child: Icon(
                  Icons.date_range_rounded,
                  size: 30,
                ),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              Future<DateTime?> future = showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              );

              future.then((date) {
                setState(() {
                  _selectedDate = date;
                });
              });
            },
            child: Container(
              padding: const EdgeInsets.all(13.0),
              decoration: BoxDecoration(
                color: GREY2,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: GREY1,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _selectedDate == null
                      ? '날짜 선택하기'
                      : '${_selectedDate}'.substring(0, 10),
                  style: TextStyle(
                      fontFamily: 'Pretendard', color: GREY1, fontSize: 22),
                )
              ]),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          GestureDetector(
            onTap: () {
              Future<TimeOfDay?> future = showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: 00, minute: 00),
              );

              future.then((time) {
                setState(() {
                  _selectedTime = time;
                });
              });
            },
            child: Container(
              padding: const EdgeInsets.all(13.0),
              decoration: BoxDecoration(
                color: GREY2,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(children: [
                Icon(
                  Icons.access_time,
                  color: GREY1,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _selectedTime == null
                      ? '시간 선택하기'
                      : '${_selectedTime}'.substring(10, 15),
                  style: TextStyle(
                      fontFamily: 'Pretendard', color: GREY1, fontSize: 22),
                )
              ]),
            ),
          )
        ]),
      )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            // 입력받은 정보 이전 페이지로 전달
            Get.back(
                result: '날짜 : ' +
                    '${_selectedDate}'.substring(0, 10) +
                    '\n시간 : ' +
                    '${_selectedTime}'.substring(10, 15));
          },
          style: ElevatedButton.styleFrom(
            primary: MAINCOLOR,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            '입력완료',
            style: TextStyle(
                fontFamily: 'Pretendard', color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
