import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:quick_logi/utilities/constants.dart';
import 'package:quick_logi/utilities/validators.dart';

import '../../utilities/components.dart';

class LoginScreen extends StatelessWidget {
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackTopBar(),
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: '로그인하기',
                            style: TextStyle(
                                fontFamily: 'PretendardBold',
                                color: Colors.black,
                                fontSize: 32),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                                fontFamily: 'PretendardBold',
                                color: SUBCOLOR1,
                                fontSize: 32),
                          ),
                        ])),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
                          child: Text(
                            '이메일 주소',
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ),
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailFocus,
                            controller: _emailController,
                            validator: (value) => CheckValidate()
                                .validateEmail(_emailFocus, value!),
                            decoration: InputDecoration(
                                fillColor: GREY2,
                                filled: true,
                                prefixIcon: Icon(Icons.email_outlined),
                                hintText: 'id@example.com',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(5))),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
                          child: Text(
                            '비밀번호',
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ),
                        TextFormField(
                            obscureText: true,
                            focusNode: _passwordFocus,
                            controller: _passwordController,
                            validator: (value) => CheckValidate()
                                .validatePassword(_passwordFocus, value!),
                            decoration: InputDecoration(
                                fillColor: GREY2,
                                filled: true,
                                prefixIcon: Icon(Icons.lock_outline_rounded),
                                hintText: '***********',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(5)))
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  _formKey.currentState!.validate();

                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password:
                                _passwordController.text) //아이디와 비밀번호로 로그인 시도
                        .then((value) {
                      print(value);
                      value.user!.emailVerified == true //이메일 인증 여부
                          ? Get.offAllNamed('/MainScreen')
                          : Get.snackbar('이메일 인증을 완료해주세요', '',
                              snackPosition: SnackPosition.TOP);
                      return value;
                    });
                  } on FirebaseAuthException catch (e) {
                    //로그인 예외처리
                    if (e.code == 'user-not-found') {
                      print('등록되지 않은 이메일입니다');
                    } else if (e.code == 'wrong-password') {
                      print('비밀번호가 틀렸습니다');
                    } else {
                      print(e.code);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: MAINCOLOR,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  '로그인',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
