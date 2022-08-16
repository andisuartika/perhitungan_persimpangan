import 'package:flutter/material.dart';

import '../theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    // HEADER
    Widget header() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Container(
              width: 125,
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/logo-apps.png',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Sign Up',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Silahkan lengkapi form untuk membuat akun',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }

    // FORM LOGIN
    Widget formSingUp() {
      return Container(
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: primaryTextColor,
                      keyboardType: TextInputType.text,
                      controller: usernameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        // NULL
                        if (value!.isEmpty) {
                          return "Masukkan username";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                        hintText: 'Masukkan Username',
                        hintStyle: primaryTextStyle.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: regular,
                        ),
                        fillColor: backgorundFieldColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: primaryTextColor,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        // NULL
                        if (value!.isEmpty) {
                          return "Masukkan email";
                        }
                        // VALID EMAIL
                        final pattern =
                            r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                        final regExp = RegExp(pattern);

                        if (!regExp.hasMatch(value)) {
                          return "Masukkan email yang valid";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                        hintText: 'Masukkan Email',
                        hintStyle: primaryTextStyle.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: regular,
                        ),
                        fillColor: backgorundFieldColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kata Sandi',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      cursorColor: primaryTextColor,
                      controller: passwordController,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukkan kata sandi";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                        hintText: 'Masukkan Kata sandi',
                        hintStyle: primaryTextStyle.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: regular,
                        ),
                        fillColor: backgorundFieldColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    // LOGIN TEXT
    Widget login() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              "Sudah Punya Akun?",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                "Login",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        height: 50,
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/access-code');
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Sign Up',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
              letterSpacing: 1,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                header(),
                formSingUp(),
                button(),
                login(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
