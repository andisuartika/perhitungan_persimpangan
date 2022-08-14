import 'package:gsheets/gsheets.dart';
import 'package:perhitungan_persimpangan/models/lv_model.dart';

class SheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-358606",
  "private_key_id": "00c8525435da65a4ebc4fe287c9452e743f2afcf",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCoGq+z5s+9+YRw\nrwMD5MH8g8J7dJi+MQfZq5//Pu4tB5ZqWGfHTfAdIhVJGo3V4bPow4Bo6AHtoFlc\noUTD699z/+t50ZXZb39qrbbAQUZJ8RiVKzSsZUJhXuLXygp4pj+t07UpCWB3r+Yy\n57ZvhcykaHcdha9bARHOD7Cf7I7E+HukeNUWBcymGNRkJG7WJH7CV0l3w0bzN3cj\n3C3i0OcxaeiW6xgq3R2ERHcUJ/LKul0KYuwrNSrkufghuqTdNpSBNH7u/O8E2X5j\nQedDBcawGIoSo//CWJYUtyAXQodCi7OfkLrUiKSVaUeXzvbdwKYLZzcWpbiQh6x8\n7acZ+qNZAgMBAAECggEAGPYNd5si5xnxI9ejjPp0y41iXXk3YlZezLWCm8tjtmVV\nXRPPenVaMsPoK+Njgt9xcB3yJ/b7V6Y4XrFw8olIXth2G1qW86MYumXHqHiI0AXw\nGTDshgTAfJDdrMkgEOuEB8hTMsq6UPYE1TOO5V8Vafw7uQiBZ0lGCYukNbr8isaq\nW6gkWGr99pyf8E4zBgqbySqCZpN7CVAdPqBpTCYJArJAKdu3b5QTGxSRmlPvW0Ja\nW1iTmdclwESq7LbmAzNHEl++7E2rzVRT2/TV7e+5LZSqC8vRgIuXqxy2dFDr6nIL\nA/u1GJQ59C7PgCocWyAQACPlhnwv40UXqkLQp+0FWQKBgQDf9HIUMPNsWX+HOUuC\nKgU0BoKpZyifbJEkuPv37TQukauVoT/SfuqD5JQnqsOjE5SmOr+9f+/wClE+nAEi\naAKBIRsUr6sX8h9o014tmtdSFZHgPllys8mg1/LVEPKDTU9GAEIpBCyRQ6bVKXOt\nbo+qgup7YYThej9Da8Lq+KovzwKBgQDAKGkbD0kIGCCt3Tig8AVbpWjQXuDwUn83\nJOiqgFGuak65w38T6vTcrPkyc12RT4YYPeQQoh0PubUfjmkY0yMk/hgDUP/vgxsk\nerP9fZdWa/eZdE9kcnpT7Fh/0lRJ4Wbdz6zBKJfHH8qpvMLRDp3u4g5FZ5nb7JrL\n0nlZuSpcVwKBgHgi1R9nsu0ohXSwk4Tbrbbe1zCwmeYLg0DDysaQhDGHCxhVS7tL\nQdpGwAMXY6MTWeZiFYE+JCQMJNEFNsaSLOXAMJrEMW/C/n5pBFhKe78Yuwwj5i/V\nqg+SSD1rvewZiLDwao0+I/o45EHs3pTmfkLlv4s4IOQjg9RS9li90+2ZAoGAJ+G7\nPtSDUdzAG5XIhQ6L7iN8h5LJmNdmc+mDKLANQ+fogwGiRF4FiC+WYPQ0vU4GBM4D\nobgj0/m1L+F8ypw3tRvPnBCZrfpGDeIxrTD90gACmaTcPXrNDNIG5DChMdxIX00V\nC9oC9l8Qzv3QaVdhTA067Qi9lDmdPyRl70tREW0CgYB62e/RQrVyfqKKSP9TCVjz\nsTl7v9oSRjvwZHlrKvc7+O7EGRvJkvjo1ibWRJJ6uauh0Xl1lJ3Y5NDa+o+3m6S5\nZZCzvCfT/+rBjBudlN0eFDXPH5fMJLspmaRmCM3DCF1ld1avu/2iQvhBdx2kRJuF\nkmXV6/xOiRh7Jn7tgnsVQQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-358606.iam.gserviceaccount.com",
  "client_id": "104905939908955793375",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-358606.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '1lOvBU4DSzNAgZ4_oF8EvCNs_FrrUHfTZZLcEw8tsBHU';
  static final _gheets = GSheets(_credentials);
  static Worksheet? _dataInput;

  static Future init() async {
    try {
      final spreadsheet = await _gheets.spreadsheet(_spreadsheetId);
      _dataInput = await _getWorkSheet(spreadsheet, title: 'Sheet1');

      final firstRow = LvModel.getFields();
      _dataInput!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future getSimpangName(String simpang) async {
    final spreadsheet = await _gheets.spreadsheet(_spreadsheetId);
    var sheet = spreadsheet.worksheetByTitle('KAKI-SIMPANG-$simpang');
    return await sheet!.values.value(column: 5, row: 2);
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future updateName(String namaSimpang, simpang) async {
    // _dataInput!.values.map.appendRows(rowList);
    final spreadsheet = await _gheets.spreadsheet(_spreadsheetId);
    var sheet = spreadsheet.worksheetByTitle('KAKI-SIMPANG-$simpang');
    await sheet!.values.insertValue(namaSimpang, column: 5, row: 2);
  }

  static Future<bool> updateLv(
    int id,
    String simpang,
    Map<String, dynamic> data,
  ) async {
    print('SIMPANG : $simpang');

    final spreadsheet = await _gheets.spreadsheet(_spreadsheetId);
    var sheet = spreadsheet.worksheetByTitle('KAKI-SIMPANG-$simpang');
    return sheet!.values.map.insertRowByKey(id, data, fromColumn: 4);
  }

  static Future<bool> updateHv(
    int id,
    String simpang,
    Map<String, dynamic> data,
  ) async {
    print('SIMPANG : $simpang');

    final spreadsheet = await _gheets.spreadsheet(_spreadsheetId);
    var sheet = spreadsheet.worksheetByTitle('KAKI-SIMPANG-$simpang');
    return sheet!.values.map.insertRowByKey(id, data, fromColumn: 11);
  }
}
