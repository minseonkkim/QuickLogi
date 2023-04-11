import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quick_logi/utilities/components.dart';
import 'package:quick_logi/utilities/constants.dart';
import 'package:quick_logi/utilities/validators.dart';

class JoinScreen extends StatelessWidget {
  FocusNode _nameFocus = new FocusNode();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Container(
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: '환영합니다',
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
                        '이름',
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        focusNode: _nameFocus,
                        decoration: InputDecoration(
                            fillColor: GREY2,
                            filled: true,
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            hintText: '홍길동',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(5))),
                    SizedBox(
                      height: 20,
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
                        validator: (value) =>
                            CheckValidate().validateEmail(_emailFocus, value!),
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
                        validator: (value) => CheckValidate()
                            .validatePassword(_passwordFocus, value!),
                        toolbarOptions: ToolbarOptions(
                          paste: false,
                        ),
                        decoration: InputDecoration(
                            fillColor: GREY2,
                            filled: true,
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            hintText: '***********',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(5))),
                  ],
                )),
              )),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.validate();
                },
                style: ElevatedButton.styleFrom(
                  primary: MAINCOLOR,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  '회원가입',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
