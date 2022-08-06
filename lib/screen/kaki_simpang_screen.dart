import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/jenis_kendaraan_screen.dart';
import 'package:perhitungan_persimpangan/theme.dart';

class KakiSimpangScreen extends StatefulWidget {
  final String simpang;
  const KakiSimpangScreen({Key? key, required this.simpang}) : super(key: key);

  @override
  State<KakiSimpangScreen> createState() => _KakiSimpangScreenState();
}

class _KakiSimpangScreenState extends State<KakiSimpangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          widget.simpang,
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
              "Silahkan Pilih Arah",
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
                    builder: (context) => JenisKendaraanScreen(
                        simpang: widget.simpang, arah: "Kanan"),
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
                      "Kanan",
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
                    builder: (context) => JenisKendaraanScreen(
                        simpang: widget.simpang, arah: "Kiri"),
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
                      "Kiri",
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
                    builder: (context) => JenisKendaraanScreen(
                        simpang: widget.simpang, arah: "Lurus"),
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
                      "Lurus",
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    )
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
