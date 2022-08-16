import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:perhitungan_persimpangan/api/sheets/sheets_api.dart';
import 'package:perhitungan_persimpangan/data/key.dart';
import 'package:perhitungan_persimpangan/models/lv_model.dart';
import 'package:perhitungan_persimpangan/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class LvScreen extends StatefulWidget {
  final String simpang;
  final String arah;
  const LvScreen({Key? key, required this.simpang, required this.arah})
      : super(key: key);

  @override
  State<LvScreen> createState() => _LvScreenState();
}

class _LvScreenState extends State<LvScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaSimpang = TextEditingController(text: '');
  String namaSimpangSheet = '';
  int totalTraffic = 0;
  int mobil = 0;
  int doubleCabin = 0;
  int mpu = 0;
  int miniBus = 0;
  int pickUp = 0;
  int miniTruck = 0;
  bool isLoading = false;

  void reset() {
    setState(() {
      totalTraffic = 0;
      mobil = 0;
      doubleCabin = 0;
      mpu = 0;
      miniBus = 0;
      pickUp = 0;
      miniTruck = 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSimpang();
    super.initState();
  }

  // LAUNCH URL
  Future<void> _launchInBrowser() async {
    const url =
        'https://docs.google.com/spreadsheets/d/1lOvBU4DSzNAgZ4_oF8EvCNs_FrrUHfTZZLcEw8tsBHU/export?format=xlsx'; //LINK DOWNLOAD
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future getSimpang() async {
    // print(await SheetsApi.getSimpangName(widget.simpang));
    setState(() {
      isLoading = true;
    });
    namaSimpang.text = await SheetsApi.getSimpangName(widget.simpang);
    setState(() {
      isLoading = false;
    });
  }

  @override

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
            "(${widget.arah.toUpperCase()})",
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
                    // SET LOADING
                    setState(() {
                      isLoading = true;
                    });

                    if (selectedTime != null && namaSimpang.text != '') {
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
                        LvModel.mobil: mobil,
                        LvModel.mpu: mpu,
                        LvModel.pickup: pickUp,
                        LvModel.truckKecil: miniTruck,
                        LvModel.busKecil: miniBus,
                        LvModel.doubleKabin: doubleCabin,
                      };
                      await SheetsApi.updateLv(id, widget.simpang, data);

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
                  "assets/lv-icon.png",
                  width: 40,
                ),
                Text(
                  'Mobil',
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
                          mobil == 0 ? totalTraffic : totalTraffic--;
                          mobil == 0 ? mobil : mobil--;
                        });
                      },
                      child: Image.asset(
                        'assets/minus-icon.png',
                        width: 40,
                      ),
                    ),
                    Text(
                      mobil.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mobil++;
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
                  "assets/doubleCabin-icon.png",
                  width: 40,
                ),
                Text(
                  'Double Kabin',
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
                          doubleCabin == 0 ? totalTraffic : totalTraffic--;
                          doubleCabin == 0 ? doubleCabin : doubleCabin--;
                        });
                      },
                      child: Image.asset(
                        'assets/minus-icon.png',
                        width: 40,
                      ),
                    ),
                    Text(
                      doubleCabin.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          doubleCabin++;
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
                  "assets/mpu-icon.png",
                  width: 40,
                ),
                Text(
                  'MPU',
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
                          mpu == 0 ? totalTraffic : totalTraffic--;
                          mpu == 0 ? mpu : mpu--;
                        });
                      },
                      child: Image.asset(
                        'assets/minus-icon.png',
                        width: 40,
                      ),
                    ),
                    Text(
                      mpu.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mpu++;
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
                  "assets/busKecil-icon.png",
                  width: 40,
                ),
                Text(
                  'Bus Kecil',
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
                          miniBus == 0 ? totalTraffic : totalTraffic--;
                          miniBus == 0 ? miniBus : miniBus--;
                        });
                      },
                      child: Image.asset(
                        'assets/minus-icon.png',
                        width: 40,
                      ),
                    ),
                    Text(
                      miniBus.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          miniBus++;
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
                  "assets/pickUp-icon.png",
                  width: 40,
                ),
                Text(
                  'Pick Up',
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
                          pickUp == 0 ? totalTraffic : totalTraffic--;
                          pickUp == 0 ? pickUp : pickUp--;
                        });
                      },
                      child: Image.asset(
                        'assets/minus-icon.png',
                        width: 40,
                      ),
                    ),
                    Text(
                      pickUp.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pickUp++;
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
                  "assets/truck-icon.png",
                  width: 40,
                ),
                Text(
                  'Truck Kecil',
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
                          miniTruck == 0 ? totalTraffic : totalTraffic--;
                          miniTruck == 0 ? miniTruck : miniTruck--;
                        });
                      },
                      child: Image.asset(
                        'assets/minus-icon.png',
                        width: 40,
                      ),
                    ),
                    Text(
                      miniTruck.toString(),
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          miniTruck++;
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
          "Light Vehicle (LV)",
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
