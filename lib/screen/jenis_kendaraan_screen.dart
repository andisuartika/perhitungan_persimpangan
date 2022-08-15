import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/hv_screen.dart';
import 'package:perhitungan_persimpangan/screen/lv_screen.dart';
import 'package:perhitungan_persimpangan/screen/mc_screen.dart';
import 'package:perhitungan_persimpangan/screen/um_screen.dart';
import 'package:perhitungan_persimpangan/theme.dart';

class JenisKendaraanScreen extends StatefulWidget {
  final String simpang;
  final String arah;
  const JenisKendaraanScreen(
      {Key? key, required this.simpang, required this.arah})
      : super(key: key);

  @override
  State<JenisKendaraanScreen> createState() => _JenisKendaraanScreenState();
}

class _JenisKendaraanScreenState extends State<JenisKendaraanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "KAKI SIMPANG ${widget.simpang} ${widget.arah.toUpperCase()}",
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
              "Silahkan Pilih Jenis Kendaraan",
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
                    builder: (context) =>
                        MCScreen(simpang: widget.simpang, arah: widget.arah),
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
                      "assets/motor-icon.png",
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Motorcycle (MC)",
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
                    builder: (context) =>
                        LvScreen(simpang: widget.simpang, arah: widget.arah),
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
                      "assets/lv-icon.png",
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Light Vehicle (LV)",
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
                    builder: (context) =>
                        HVScreen(simpang: widget.simpang, arah: widget.arah),
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
                      "assets/hv-icon.png",
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "High Vehicle (HV)",
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
                    builder: (context) =>
                        UMScreen(simpang: widget.simpang, arah: widget.arah),
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
                      "assets/sepeda-icon.png",
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Unmotorized (UM)",
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
