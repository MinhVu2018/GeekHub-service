import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ext_storage/ext_storage.dart';

import 'customer.dart';

class StorageManger {
  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/account.csv';

    return filePath;
  }

  Future<void> createIfNotExist() async {
    String filePath = await getFilePath();
    bool isExist = await File(filePath).exists();
    if (isExist == false) {
      new File(filePath).create(recursive: true);
    }
  }

  Future<void> write(List<dynamic> lstCustomer) async {
    String filePath = await getFilePath();

    List<List<dynamic>> lst = [];
    for (int i = 0; i < lstCustomer.length; i++)
      lst.add(lstCustomer[i].toList());
    String csv = ListToCsvConverter().convert(lst);

    File file = File(filePath);
    file.writeAsString(csv);
  }

  Future<List<Customer>> read() async {
    String filePath = await getFilePath();

    final input = new File(filePath).openRead();
    List<List> fields = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();

    List<Customer> ans = [];
    for (int i = 0; i < fields.length; i++)
      ans.add(Customer.fromList(fields[i]));
    return ans;
  }

  Future<void> export(List<dynamic> lstCustomer) async {
    var appDocumentsDirectory =
        await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_DOWNLOADS);
    String filePath = '$appDocumentsDirectory/account.csv';

    List<List<dynamic>> lst = [];
    for (int i = 0; i < lstCustomer.length; i++)
      lst.add(lstCustomer[i].toList());
    String csv = ListToCsvConverter().convert(lst);

    File file = File(filePath);
    file.writeAsString(csv);
  }
}
