import 'dart:math';

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

class Customer {
  late String type;
  late String purchaseDate;
  late String familyAccount;
  late String? warrantyCode;

  Customer(this.type, this.purchaseDate, this.familyAccount,
      [this.warrantyCode]);

  String? getImagePath() {
    if (type == 'Sportify') return 'assets/sportify_logo.png';
    if (type == 'Youtube') return 'assets/youtube_logo.png';
    if (type == 'Netflix') return 'assets/netflix_logo.png';
  }

  List<String> toList() {
    return [
      type,
      purchaseDate,
      familyAccount,
      warrantyCode!,
    ];
  }

  Customer.fromList(List<dynamic> lst)
      : type = lst[0],
        purchaseDate = lst[1],
        familyAccount = lst[2],
        warrantyCode = lst[3];

  void generateWarrantyCode() {
    this.warrantyCode = getRandomString(5);
  }
}

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));
