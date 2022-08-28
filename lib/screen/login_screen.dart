import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/access_code_screen.dart';
import 'package:perhitungan_persimpangan/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  bool hidden = true;
  @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();

  //   super.dispose();
  // }

  // HIDDEN PASSWORD
  passwordHidden() async {
    setState(() {
      hidden = !hidden;
    });
  }

  Widget build(BuildContext context) {
    Future login() async {
      // LOADING
      showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        // SHARED PREFERENCES
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Success!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AccessCodeScreen()),
            (route) => false);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        print('Failed with error code: ${e.code}');
        switch (e.code) {
          case "user-not-found":
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Email tidak terdaftar!'),
                backgroundColor: Colors.red,
              ),
            );
            break;
          case "wrong-password":
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password salah!'),
                backgroundColor: Colors.red,
              ),
            );
            break;
          case "too-many-requests":
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.code),
                backgroundColor: Colors.red,
              ),
            );
            break;
        }
        print(e.message);
      }
    }

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
            Text(
              'Selamat datang,\n Traffic Count Analyzer',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Silahkan Login untuk dapat menggunakan aplikasi',
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
    Widget formLogin() {
      return Container(
        child: Column(
          children: [
            Container(
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
                    'Password',
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
                      obscureText: hidden,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukkan password";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                        hintText: 'Masukkan password',
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
                        suffixIcon: GestureDetector(
                          onTap: passwordHidden,
                          child: hidden
                              ? Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                )
                              : Icon(
                                  Icons.remove_red_eye,
                                  color: primaryColor,
                                ),
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

    Widget button() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        height: 50,
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            if (emailController.text != null &&
                passwordController.text != null) {
              login();
            }

            // Navigator.pushNamed(context, '/access-code');
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Login',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
              letterSpacing: 1,
            ),
          ),
        ),
      );
    }

    // SIGNUP TEXT
    Widget signUp() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              "Belum Punya Akun?",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-up');
              },
              child: Text(
                "Sign Up",
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
                formLogin(),
                button(),
                signUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
