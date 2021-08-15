import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:math';

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

enum Type { sportify, youtube, netflix }

class Customer {
  late Type type;
  late DateTime purchaseDate;
  late String familyAccount;
  late String? warrantyCode;

  Customer(this.type, this.purchaseDate, this.familyAccount,
      [this.warrantyCode]);

  String getDate() {
    return DateFormat("dd-MM-yyyy").format(purchaseDate);
  }

  String? getImagePath() {
    if (type == Type.sportify) return 'assets/sportify_logo.png';
    if (type == Type.youtube) return 'assets/youtube_logo.png';
    if (type == Type.netflix) return 'assets/netflix_logo.png';
  }

  List<String> toList() {
    return [
      describeEnum(type).toString(),
      DateFormat("yyyy-MM-dd").format(purchaseDate),
      familyAccount,
      warrantyCode!,
    ];
  }

  Customer.fromList(List<dynamic> lst)
      : type = EnumToString.fromString(Type.values, lst[0])!,
        purchaseDate = DateTime.parse(lst[1]),
        familyAccount = lst[2],
        warrantyCode = lst[3];

  void generateWarrantyCode() {
    this.warrantyCode = getRandomString(5);
  }
}

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));

// List<Customer> lstCustomer = [
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.youtube, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.youtube, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.youtube, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.youtube, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.youtube, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
//   Customer(Type.sportify, DateTime.parse("2021-01-02"), 'xyz:abc', 'AXX12'),
//   Customer(Type.netflix, DateTime.parse("2021-01-02"), 'aaa:bbb', 'B12XA'),
// ];

List<Customer> lstCustomer = [];
// Type: sportify
// purchase date: 7/8/2021
// Family account: abc:xyz
// Warranty code: random...