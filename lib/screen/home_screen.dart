import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/kaki_simpang_screen.dart';
import 'package:perhitungan_persimpangan/screen/login_screen.dart';
import 'package:perhitungan_persimpangan/screen/persimpangan_screen.dart';
import 'package:perhitungan_persimpangan/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String accessCode = '';

  @override
  void initState() {
    // TODO: implement initState
    getAccessCode();
    super.initState();
  }

  getAccessCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessCode = prefs.getString('access-code')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final formKey = GlobalKey<FormState>();
    TextEditingController namaSimpang = TextEditingController(text: '');

    // HEADER
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          right: 30,
          left: 30,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hallo, Selamat datang!',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  '${user.email}',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                ),
                // Row(
                //   children: [
                //     Image.asset(
                //       "assets/location-icon.png",
                //       width: 18,
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     Text(
                //       "Denpasar, Bali",
                //       style: primaryTextStyle.copyWith(
                //         fontSize: 12,
                //         fontWeight: regular,
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
            GestureDetector(
              onTap: () async {
                // SIGNOUT FIREBASE
                FirebaseAuth.instance.signOut();

                // SHARED PREFERENCES SIGNOUT
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLogin', false);
                prefs.setString('sheetId', '');
                prefs.setString('access-code', '');

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
              child: Icon(Icons.logout),
            )
            // ClipOval(
            //     child: Image.asset(
            //   "assets/profile.png",
            //   width: 50,
            // ))
          ],
        ),
      );
    }

    // SLIDER
    final List<String> images = [
      'assets/banner.png',
      'assets/banner.png',
      'assets/banner.png',
    ];
    Widget slider() {
      return Container(
        child: CarouselSlider.builder(
          itemCount: images.length,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          itemBuilder: (context, index, realIdx) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(images[index],
                      fit: BoxFit.cover, width: 1000),
                ),
              ),
            );
          },
        ),
      );
    }

    // CONTAINER
    Widget content() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kode Akses : $accessCode',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/access-code'),
                  child: Text(
                    'Ganti Kode',
                    style: whiteTextStyle.copyWith(
                        fontSize: 10, fontWeight: regular),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Sebelum melakukan perhitungan masukkan nama simpang terlebih dahulu!',
              style: whiteTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                style: whiteTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
                controller: namaSimpang,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukkan password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusColor: primaryColor,
                  hintText: "Masukkan simpang...",
                  hintStyle: whiteTextStyle.copyWith(fontSize: 14),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              onTap: () {
                if (namaSimpang.text != '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersimpanganScreen(
                        namaSimpang: namaSimpang.text,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Masukkan nama simpang terlebih dahulu'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Mulai',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      body: SafeArea(
        child: Column(
          children: [
            header(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    slider(),
                    content(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
