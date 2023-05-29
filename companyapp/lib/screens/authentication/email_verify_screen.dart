import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/components.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:get/get.dart';


class EmailVerifyScreen extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackTopBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '인증 이메일이 발송되었습니다!',
            style: TextStyle(
                fontFamily: 'Pretendard', color: Colors.black, fontSize: 25),
          ),
          SizedBox(
            height: 10,
          ),
          Icon(
            Icons.check_circle_rounded,
            size: 60,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '회원가입을 완료하려면 이메일 인증이 필요합니다.',
            style:
                TextStyle(fontFamily: 'Pretendard', color: GREY1, fontSize: 15),
          ),
          Text(
            '받은 편지함을 확인하시고 제공된 지시에 따라주십시오.',
            style:
                TextStyle(fontFamily: 'Pretendard', color: GREY1, fontSize: 15),
          ),
          Text(
            '이메일이 발송된 주소는 다음과 같습니다.',
            style:
                TextStyle(fontFamily: 'Pretendard', color: GREY1, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            auth.currentUser!.email.toString(),
            style: TextStyle(
                fontFamily: 'PretendardBold', color: GREY1, fontSize: 17),
          )
        ],
      )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: OutlinedButton(
          onPressed: () {
            Get.toNamed('/LoginScreen');
          },
          style: OutlinedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            side: BorderSide(width: 2.0, color: GREY1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            '로그인하기',
            style:
                TextStyle(fontFamily: 'Pretendard', color: GREY1, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
