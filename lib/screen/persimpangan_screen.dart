import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/kaki_simpang_screen.dart';

import '../theme.dart';

class PersimpanganScreen extends StatefulWidget {
  final String namaSimpang;
  const PersimpanganScreen({Key? key, required this.namaSimpang})
      : super(key: key);

  @override
  State<PersimpanganScreen> createState() => _PersimpanganScreenState();
}

class _PersimpanganScreenState extends State<PersimpanganScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'KAKI SIMPANG',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
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
                    builder: (context) => KakiSimpangScreen(
                        namaSimpang: widget.namaSimpang, simpang: "SELATAN"),
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
                    builder: (context) => KakiSimpangScreen(
                        namaSimpang: widget.namaSimpang, simpang: "UTARA"),
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
                    builder: (context) => KakiSimpangScreen(
                        namaSimpang: widget.namaSimpang, simpang: "TIMUR"),
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
                    builder: (context) => KakiSimpangScreen(
                        namaSimpang: widget.namaSimpang, simpang: "BARAT"),
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
      ),
    );
  }
}
