import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/api/sheets/sheets_api.dart';
import 'package:perhitungan_persimpangan/data/key.dart';
import 'package:perhitungan_persimpangan/models/lv_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

class MCScreen extends StatefulWidget {
  final String simpang;
  final String arah;
  const MCScreen({Key? key, required this.simpang, required this.arah})
      : super(key: key);

  @override
  State<MCScreen> createState() => _MCScreenState();
}

class _MCScreenState extends State<MCScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaSimpang = TextEditingController(text: '');
  String textArah = '';
  int totalTraffic = 0;
  int motor = 0;
  bool isLoading = false;

  // RESET DATA
  void reset() {
    setState(() {
      totalTraffic = 0;
      motor = 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSimpang();

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

  Future getSimpang() async {
    setState(() {
      isLoading = true;
    });
    namaSimpang.text = await SheetsApi.getSimpangName(widget.simpang);
    setState(() {
      isLoading = false;
    });
  }

  // CONTAINER INFORMASI
  String? selectedTime;
  Widget containerHeader() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            "KAKI SIMPANG ${widget.simpang}",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Nama Simpang : ",
                style:
                    whiteTextStyle.copyWith(fontSize: 12, fontWeight: medium),
              ),
              Expanded(
                child: Container(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: whiteTextStyle.copyWith(fontSize: 12),
                    controller: namaSimpang,
                    decoration: InputDecoration(
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusColor: primaryColor,
                      hintText: "Masukkan simpang...",
                      hintStyle: whiteTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
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
          SizedBox(height: 10),
          Center(
            child: Text(
              "Total Traffic : $totalTraffic",
              style: whiteTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          isLoading
              ? Container(
                  height: 35,
                  width: 150,
                  decoration: BoxDecoration(
                    color: backgorundColor,
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
                    if (selectedTime != null && namaSimpang.text != '') {
                      // SET LOADING
                      setState(() {
                        isLoading = true;
                      });

                      // UPDATE NAMA SIMPANG
                      await SheetsApi.updateName(
                          namaSimpang.text, widget.simpang);

                      // UPDATE NILAI TRAFFIC
                      var queryKey = KeySheet.waktu.where((prod) =>
                          prod["waktu"] == '${selectedTime!}_${widget.arah}');
                      var id = queryKey.single['key'];
                      print(id);
                      final data = {
                        LvModel.id: 1,
                        LvModel.namaSimpang: namaSimpang.text,
                        LvModel.waktu: selectedTime,
                        LvModel.mc: motor,
                      };
                      await SheetsApi.updateMc(id, widget.simpang, data);

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
                          content: Text("Masukkan Nama Simpang dan Waktu!"),
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
                    height: 35,
                    width: 150,
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

  Widget vihicle() {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 100,
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/motor-icon.png",
                  width: 40,
                ),
                Text(
                  'Sepeda Motor',
                  style: whiteTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          motor == 0 ? totalTraffic : totalTraffic--;
                          motor == 0 ? motor : motor--;
                        });
                      },
                      child: Image.asset(
                        'assets/minus-icon.png',
                        width: 40,
                      ),
                    ),
                    Text(
                      motor.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          motor++;
                          totalTraffic++;
                        });
                      },
                      child: Image.asset(
                        'assets/plus-icon.png',
                        width: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Motorcycle (MC)",
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
              vihicle(),
              GestureDetector(
                onTap: reset,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Reset',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
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
