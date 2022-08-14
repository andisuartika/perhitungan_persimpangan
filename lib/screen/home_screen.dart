import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/kaki_simpang_screen.dart';
import 'package:perhitungan_persimpangan/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'Hallo, Selamat Datang!',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Perhitungan Persimpangan',
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

    // PILIH SIMPANG
    Widget simpang() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Silahkan Pilih Persimpangan",
              style:
                  primaryTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KakiSimpangScreen(simpang: "SELATAN"),
                  ),
                );
              },
              child: Container(
                height: 85,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryColor,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/selatan-icon.png",
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Kaki Simpang Selatan",
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KakiSimpangScreen(simpang: "UTARA"),
                  ),
                );
              },
              child: Container(
                height: 85,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryColor,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/utara-icon.png",
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Kaki Simpang Utara",
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KakiSimpangScreen(simpang: "TIMUR"),
                  ),
                );
              },
              child: Container(
                height: 85,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryColor,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/timur-icon.png",
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Kaki Simpang Timur",
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KakiSimpangScreen(simpang: "BARAT"),
                  ),
                );
              },
              child: Container(
                height: 85,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryColor,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/barat-icon.png",
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Kaki Simpang Barat",
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
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
                    simpang(),
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
