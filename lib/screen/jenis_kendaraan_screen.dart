import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/screen/hv_screen.dart';
import 'package:perhitungan_persimpangan/screen/input_screen.dart';
import 'package:perhitungan_persimpangan/screen/lv_screen.dart';
import 'package:perhitungan_persimpangan/screen/mc_screen.dart';
import 'package:perhitungan_persimpangan/screen/um_screen.dart';
import 'package:perhitungan_persimpangan/theme.dart';

class JenisKendaraanScreen extends StatefulWidget {
  final String namaSimpang;
  final String simpang;
  final String arah;

  const JenisKendaraanScreen(
      {Key? key,
      required this.simpang,
      required this.arah,
      required this.namaSimpang})
      : super(key: key);

  @override
  State<JenisKendaraanScreen> createState() => _JenisKendaraanScreenState();
}

class _JenisKendaraanScreenState extends State<JenisKendaraanScreen> {
  List<String> vihecle = [];
  bool mcSelected = false,
      lvSelected = false,
      hvSelected = false,
      umSelected = false;
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
                setState(() {
                  if (mcSelected == false && vihecle.length == 2) {
                    print('Lebih dari 2');
                  } else {
                    mcSelected = !mcSelected;
                    if (mcSelected == true) {
                      vihecle.add('MC');
                    } else {
                      vihecle.removeWhere((element) => element == 'MC');
                    }
                  }
                });
                print(vihecle);
              },
              child: Container(
                height: 85,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: mcSelected ? primaryColor : secondaryColor,
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
                setState(() {
                  if (lvSelected == false && vihecle.length == 2) {
                    print('Lebih dari 2');
                  } else {
                    lvSelected = !lvSelected;
                    if (lvSelected == true) {
                      vihecle.add('LV');
                    } else {
                      vihecle.removeWhere((element) => element == 'LV');
                    }
                  }
                });
                print(vihecle);
              },
              child: Container(
                height: 85,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: lvSelected ? primaryColor : secondaryColor,
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
                setState(() {
                  if (hvSelected == false && vihecle.length == 2) {
                    print('Lebih dari 2');
                  } else {
                    hvSelected = !hvSelected;
                    if (hvSelected == true) {
                      vihecle.add('HV');
                    } else {
                      vihecle.removeWhere((element) => element == 'HV');
                    }
                  }
                });
                print(vihecle);
              },
              child: Container(
                height: 85,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: hvSelected ? primaryColor : secondaryColor,
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
                setState(() {
                  if (umSelected == false && vihecle.length == 2) {
                    print('Lebih dari 2');
                  } else {
                    umSelected = !umSelected;
                    if (umSelected == true) {
                      vihecle.add('UM');
                    } else {
                      vihecle.removeWhere((element) => element == 'UM');
                    }
                  }
                });
                print(vihecle);
              },
              child: Container(
                height: 85,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: umSelected ? primaryColor : secondaryColor,
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Pilih maksimal 2 jenis kendaraan!',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
      bottomSheet: vihecle.isNotEmpty
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => InputScreen(
                          simpang: widget.simpang,
                          arah: widget.arah,
                          namaSimpang: widget.namaSimpang,
                          vihecle: vihecle,
                        )),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Lanjutkan',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
