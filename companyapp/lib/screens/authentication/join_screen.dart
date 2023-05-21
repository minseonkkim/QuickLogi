import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/components.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:flutter_application_1/utilities/validators.dart';
import 'package:get/get.dart';


class JoinScreen extends StatelessWidget {
  FocusNode _nameFocus = new FocusNode();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();

  TextEditingController _nameController = TextEditingController();
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
                        controller: _nameController,
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
                        controller: _emailController,
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
                        controller: _passwordController,
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
                onPressed: () async {
                  _formKey.currentState!.validate();

                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) {
                      if (value.user!.email == null) {
                      } else {
                        Get.toNamed('/EmailVerifyScreen');
                      }
                      return value;
                    });
                    FirebaseAuth.instance.currentUser?.sendEmailVerification();

                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      user.updateProfile(displayName: _nameController.text);
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('the password provided is too weak');
                    } else if (e.code == 'email-already-in-use') {
                      Get.snackbar('이미 존재하는 이메일 주소입니다.', '');
                      print('The account already exists for that email.');
                    } else {
                      print('11111');
                    }
                  } catch (e) {
                    print('끝');
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
