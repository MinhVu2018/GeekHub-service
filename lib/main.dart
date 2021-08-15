import 'package:acc_manager/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'customer.dart';
import 'package:enum_to_string/enum_to_string.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'ACCOUNT MANAGER',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Customer> lstDefault = [];
  List<Customer> lstDisplay = [];
  StorageManger storage = new StorageManger();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await storage.createIfNotExist();
    lstDefault = await storage.read();
    lstDisplay = lstDefault;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('ACCOUNT MANAGER'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_to_home_screen),
            onPressed: export,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _displayAddInputDialog(context);
                  },
                  child: Text('+ Add customer'),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _displayRemoveInputDialog(context);
                  },
                  child: Text('-- Delete customer'),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search by Warranty Code ...",
              ),
              onChanged: (text) {
                setState(() {
                  lstDisplay = search(text);
                });
              },
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(3),
                4: FlexColumnWidth(3),
              },
              border: TableBorder.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 2,
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                  ),
                  children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'ID',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Type',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Purchase Date',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Family Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Warranty Code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 450,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: SingleChildScrollView(
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(3),
                  3: FlexColumnWidth(3),
                  4: FlexColumnWidth(3),
                },
                border: TableBorder.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 2,
                ),
                children: generateData(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TableRow> generateData() {
    List<TableRow> rows = [];
    for (int i = 0; i < lstDisplay.length; ++i) {
      Customer customer = lstDisplay[i];
      rows.add(
        TableRow(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(i.toString()),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image(
                    image: AssetImage(customer.getImagePath()!),
                    height: 25,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(customer.getDate()),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(customer.familyAccount),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(customer.warrantyCode!),
                )
              ],
            ),
          ],
        ),
      );
    }
    return rows;
  }

  void _displayRemoveInputDialog(BuildContext context) async {
    TextEditingController _textFieldController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete customer'),
          content: TextField(
            onChanged: (value) {},
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter Warranty Code"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                bool isRemoved = remove(_textFieldController.text);
                String message = isRemoved ? "Successful" : "Not found";
                Fluttertoast.showToast(
                    msg: message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1);
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _displayAddInputDialog(BuildContext context) async {
    List<String> listType = ['Sportify', 'Youtube', 'Netflix'];
    String typeSelected = 'Sportify';
    DateTime dateSelected = DateTime(2010, 1, 1);

    TextEditingController familyAccountCtrl = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 280,
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Choose type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  items: listType.map((String category) {
                    return new DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() => typeSelected = newValue as String);
                  },
                  value: typeSelected,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    'Choose date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: 300,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: dateSelected,
                    onDateTimeChanged: (DateTime newDateTime) {
                      dateSelected = newDateTime;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    'Enter Family account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (value) {},
                  controller: familyAccountCtrl,
                  decoration:
                      InputDecoration(hintText: "Enter Family Account ..."),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Customer customer = new Customer(
                    EnumToString.fromString(Type.values, typeSelected)!,
                    dateSelected,
                    familyAccountCtrl.text);
                add(customer);
                Clipboard.setData(ClipboardData(text: customer.warrantyCode));
                Fluttertoast.showToast(
                    msg: "Copied",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1);
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  bool remove(String input) {
    for (int i = 0; i < lstDefault.length; i++)
      if (lstDefault[i].warrantyCode == input) {
        lstDefault.removeAt(i);
        storage.write(lstDefault);
        setState(() {
          lstDisplay = lstDefault;
        });
        return true;
      }
    return false;
  }

  void add(Customer customer) {
    while (true) {
      customer.generateWarrantyCode();
      if (search(customer.warrantyCode!).isEmpty) {
        break;
      }
    }

    lstDefault.add(customer);
    storage.write(lstDefault);
    setState(() {
      lstDisplay = lstDefault;
    });
  }

  List<Customer> search(String warrantyCode) {
    if (warrantyCode.isEmpty) return lstDefault;

    List<Customer> temp = [];
    for (int i = 0; i < lstDefault.length; i++)
      if (lstDefault[i].warrantyCode!.contains(warrantyCode))
        temp.add(lstDefault[i]);

    return temp;
  }

  void export() async {
    await storage.export(lstDefault);
  }
}
