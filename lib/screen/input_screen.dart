import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/api/sheets/sheets_api.dart';
import 'package:perhitungan_persimpangan/data/key.dart';
import 'package:perhitungan_persimpangan/models/lv_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

class InputScreen extends StatefulWidget {
  final String namaSimpang;
  final String simpang;
  final String arah;
  final List<String> vihecle;
  const InputScreen(
      {Key? key,
      required this.simpang,
      required this.arah,
      required this.namaSimpang,
      required this.vihecle})
      : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String textArah = '';
  int lv = 0;
  int hv = 0;
  int mc = 0;
  int um = 0;
  bool isLoading = false, isVihecle2 = false;

  // RESET DATA
  void reset() {
    setState(() {
      lv = 0;
      hv = 0;
      mc = 0;
      um = 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.vihecle.length == 2) {
      setState(() {
        isVihecle2 = true;
        print('TRUE');
      });
    }

    // CONVERT TEXT ARAH
    if (widget.arah == 'Kiri') {
      textArah = 'Belok Kiri';
    } else if (widget.arah == 'Kanan') {
      textArah = 'Belok Kanan';
    } else {
      textArah = 'Lurus';
    }
    super.initState();
  }

  // LAUNCH URL
  Future<void> _launchInBrowser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    var sheetId = prefs.getString('sheetId')!;
    var link =
        'https://docs.google.com/spreadsheets/d/${sheetId.toString()}/export?format=xlsx'; //LINK DOWNLOAD
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  // CONTAINER INFORMASI
  String? selectedTime;
  Widget containerHeader() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(10),
      height: 175,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            "${widget.namaSimpang.toUpperCase()} KAKI SIMPANG ${widget.simpang}",
            style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
          ),
          Text(
            "(${textArah.toUpperCase()})",
            style: whiteTextStyle.copyWith(fontWeight: semiBold),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Waktu : ",
                style:
                    whiteTextStyle.copyWith(fontSize: 12, fontWeight: medium),
              ),
              Expanded(
                child: Container(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Pilih Waktu...',
                        style: TextStyle(
                          fontSize: 12,
                          color: whiteColor,
                        ),
                      ),
                      items: KeySheet.times
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedTime,
                      onChanged: (value) {
                        setState(() {
                          selectedTime = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 10),
          // Center(
          //   child: Text(
          //     "Total Traffic : $totalTraffic",
          //     style: whiteTextStyle.copyWith(
          //       fontSize: 16,
          //       fontWeight: bold,
          //     ),
          //   ),
          // ),
          SizedBox(height: 15),
          isLoading
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Loading...",
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () async {
                    if (selectedTime != null && widget.namaSimpang != '') {
                      // SET LOADING
                      setState(() {
                        isLoading = true;
                      });

                      // UPDATE NAMA SIMPANG
                      await SheetsApi.updateName(
                          widget.namaSimpang, widget.simpang);

                      // UPDATE NILAI TRAFFIC
                      var queryKey = KeySheet.waktu.where((prod) =>
                          prod["waktu"] == '${selectedTime!}_${widget.arah}');
                      var id = queryKey.single['key'];
                      print(id);
                      final data = {
                        LvModel.id: 1,
                        LvModel.namaSimpang: widget.namaSimpang,
                        LvModel.waktu: selectedTime,
                        LvModel.mc: mc,
                        LvModel.lv: lv,
                        LvModel.hv: hv,
                        LvModel.um: um,
                      };
                      await SheetsApi.updateMc(id, widget.simpang, data);

                      // RESET
                      reset();

                      // BERHASIL DISIMPAN
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Data Berhasil disimpan!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      // VALIDASI FORM NAMA SIMPANG DAN WAKTU
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Masukkan Waktu!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    // SET LOADING
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Simpan",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget Mc() {
    return GestureDetector(
      onTap: () {
        setState(() {
          mc++;
        });
      },
      child: Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/motor-icon.png",
              width: 100,
            ),
            Text(
              'Sepeda Motor (MC)',
              style: whiteTextStyle.copyWith(
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${mc}',
              style: whiteTextStyle.copyWith(
                fontSize: 32,
                fontWeight: semiBold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Lv() {
    return GestureDetector(
      onTap: () {
        setState(() {
          lv++;
        });
      },
      child: Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/lv-icon.png",
              width: 100,
            ),
            Text(
              'Light Vehicle (LV)',
              style: whiteTextStyle.copyWith(
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${lv}',
              style: whiteTextStyle.copyWith(
                fontSize: 32,
                fontWeight: semiBold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Hv() {
    return GestureDetector(
      onTap: () {
        setState(() {
          hv++;
        });
      },
      child: Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/hv-icon.png",
              width: 100,
            ),
            Text(
              'Light Vehicle (LV)',
              style: whiteTextStyle.copyWith(
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${hv}',
              style: whiteTextStyle.copyWith(
                fontSize: 32,
                fontWeight: semiBold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Um() {
    return GestureDetector(
      onTap: () {
        setState(() {
          um++;
        });
      },
      child: Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/sepeda-icon.png",
              width: 100,
            ),
            Text(
              'Unmotorized (UM)',
              style: whiteTextStyle.copyWith(
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${um}',
              style: whiteTextStyle.copyWith(
                fontSize: 32,
                fontWeight: semiBold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Vihecle1() {
    if (widget.vihecle.first == 'MC') {
      return Mc();
    } else if (widget.vihecle.first == 'LV') {
      return Lv();
    } else if (widget.vihecle.first == 'HV') {
      return Hv();
    } else {
      return Um();
    }
  }

  Widget Vihecle2() {
    if (widget.vihecle.last == 'MC') {
      return Mc();
    } else if (widget.vihecle.last == 'LV') {
      return Lv();
    } else if (widget.vihecle.last == 'HV') {
      return Hv();
    } else {
      return Um();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Input Kendaraan",
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
        actions: [
          GestureDetector(
            onTap: () {
              _launchInBrowser();
              print("Launch SpreedSheet");
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset(
                "assets/file-icon.png",
                width: 24,
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              containerHeader(),
              Vihecle1(),
              SizedBox(height: 20),
              isVihecle2 ? Vihecle2() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
