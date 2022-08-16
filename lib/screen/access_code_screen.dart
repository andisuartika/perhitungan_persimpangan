import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/theme.dart';

class AccessCodeScreen extends StatefulWidget {
  const AccessCodeScreen({Key? key}) : super(key: key);

  @override
  State<AccessCodeScreen> createState() => _AccessCodeScreenState();
}

class _AccessCodeScreenState extends State<AccessCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kode Akses',
                style: primaryTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                'Silahkan Masukkan Kode Akses Tim Anda',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  cursorColor: primaryTextColor,
                  keyboardType: TextInputType.text,
                  controller: codeController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    // NULL
                    if (value!.isEmpty) {
                      return "Masukkan kode akses";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                    hintText: 'Masukkan Kode Akses',
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
                      Icons.lock_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 50,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Lanjutkan',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
