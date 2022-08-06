import 'package:gsheets/gsheets.dart';
import 'package:perhitungan_persimpangan/models/lv_model.dart';

class SheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-358606",
  "private_key_id": "fcfc1491379becf2c1c7b66ea3d310b6da17cb6a",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCngmnWvz9D1GXo\ncnbJlLq6qKOUbxmEXnIT5LYPKpnwn+/M6n6ZOl3+HJn908I/92GzSePjbhr6k72N\nsOaP++xNfA8xzGHmdx3iUkIt1mFFBmUpeoYWqLdiX9FhuzWyog8G2WGACc96OfP+\nFhONowwGbZGqdK9VIev/6mO9+xqydrsBQS0pWhJmUPylTv4TTepiiRDbrRclBO4m\nuwWohaCpp649gtEm7UzR1gotw6Wudw/xRXeyJ/l/pAAxQrAIduH5gtR4iUU8aeLR\nYuPMSQ+RJKJA2qz1hQMOTi1zgPsFAE4T/7ChdB11njo2EgGNgAIkETV9XrN5UvCC\n9Edo18VNAgMBAAECgf8QP8EEk94PNmCsVm4vdRNSsrPWMkYcu7dVNq/HyNol/V3F\nraRE4486lzZY6QcZgrsiKTNyBxGW5737gK2Hn2h3cRFdmKCROqeAzM9JTa0h2lJL\nM8IjcI+u0Jyps6oB1Lagc3XXIHHVPsnsW+KJsBylLaZzt9305CrV0xGEhwHlTcxK\nlXTsszo9uIRINUjl5RE5kkgpx4yxuTlIklVuJfB+wSLmooVmqTTSb4ENYCjkMN3R\nYlLW9kOIWdtndDrXDYkM5/SOSkCPmLLZciRZPh49Z1279A33ZLHnIwb648UHHey0\nrvvH8U7XOHPykRp/DWSuFkYpkPmpK+wUCMtpQ4MCgYEA2ArrOqJXSdW9Ue4tVy7x\nHTHWlhTQDyWweZ/nRPCBQmG9W8ThRX54Ka36j+0vZ3xicNa4KteqwG73lgSa6Syx\nJzGHvgrtN+h+8BGSjLOUGXeG6bRoa8u/2lRQijRlTlUa+NCc81K8VLT78L0gDW6O\ncKy2T6zcm1nu8xdE2DjTpEMCgYEAxn2RPgmwdrN49JC7mA127lGhOoGBftGPt3YJ\nhkiGkhCnraXxYg2rAqvYHZlxadUftVlB9lvXN2cdOt+Rx0NhpRlWFtIq6siXhVj0\ngnM9CS4B/0mVE5n8MbMicDdfiyzFLdsu9l7xSGi3UFSpRDjTx8Tfqou17/uDx001\nCmE9ny8CgYA5s7DgGDv4HH5UQ6kYgBEmGwmVTDnF0eswkOTUJOhhMnnA6PTB+uVd\nPHqPtmnS2gXw3WiTCMcyXnECQHifjrBCJ5h5ybFSHWbJ9+eMbOpBYwtFoEnDgMfd\nKGfageQM5+4sRouk8ZQbi7s+sUS+Uaj5ryeCYEkLtRl9E9nvZj4gwQKBgQCgL9I5\neORax3iEFxHuIl+q8WHmr4FscX9ElhQVtQ41bw+DinqFoXYzj6+4I49t07vlRQWA\n5pmHcsYaLzec0npJHWtmu3I7TGtMCIA7jvjhIaom9qFC0nC/Q0w1t9p5nUX8Pflm\nhzS+NRRL1idMkXgIro+7OUk5RYgSHfMCT3vFrQKBgCsgXdkR+wSBwxtV/oude2Cl\nXnolPRfAmAJBIYIy9AgRYnmgWfQ/UKN9Xa72VHERAcimyg7ThEUvTMc7pgbl+dzI\np7ja+VlEFz8iRYLc3rCPAQeWK1oNWYSTZAjhR8uUk3cG/HOGCk8Ri5OlrOdq/tbB\nbfxqGlF3xtWtUIZeTryg\n-----END PRIVATE KEY-----\n",
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

  static Future insert(List<Map<String, dynamic>> rowList) async {
    // _dataInput!.values.map.appendRows(rowList);
    // final spreadsheet = await _gheets.spreadsheet(_spreadsheetId);
    // var sheet = spreadsheet.worksheetByTitle('DATA_INPUT_B');
    // await sheet!.values.insertValue('SIMPANG HAHA', column: 4, row: 2);
  }

  static Future<bool> updateLv(
    int id,
    Map<String, dynamic> data,
  ) async {
    final spreadsheet = await _gheets.spreadsheet(_spreadsheetId);
    var sheet = spreadsheet.worksheetByTitle('KAKI-SIMPANG-SELATAN');
    return sheet!.values.map.insertRowByKey(id, data, fromColumn: 4);
  }

  static Future<bool> updateHv(
    int id,
    Map<String, dynamic> data,
  ) async {
    final spreadsheet = await _gheets.spreadsheet(_spreadsheetId);
    var sheet = spreadsheet.worksheetByTitle('KAKI-SIMPANG-SELATAN');
    return sheet!.values.map.insertRowByKey(id, data, fromColumn: 11);
  }
}
