import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mmpos/API/service_api.dart';
import 'package:mmpos/provider/store.dart';
import 'package:provider/provider.dart';

class Old extends StatefulWidget {
  const Old({super.key});

  @override
  State<Old> createState() => _OldState();
}

class _OldState extends State<Old> {
  TextEditingController val = TextEditingController();
  int sumAll = 0;
  bool err = false;
  bool barcode = false;
  bool amount = false;
  bool onStream = true;
  List table = [];
  List rgb = ["156", "39", "176"];
  String rgbSt = "156, 39, 176";
  TextEditingController nameCate = TextEditingController();
  TextEditingController searcBarcode = TextEditingController();
  var sell = new TextEditingController();
  TextEditingController search = TextEditingController();
  String? prompayImage;
  bool prompay = true;
  int setSideBar = 0;
  bool getData = true;
  int priceSum = 0;
  bool onOff = true;
  var colorsPicked = const Color(0xfff44336);
  List getItem = [
    {
      "u_id": "46",
      "name": "test",
      "image": "244,67,54",
      "price": "232",
      "items_barcode": "232",
      "category": "history",
      "type": "สินค้ามี Serial",
      "weight": "32323",
      "check_list": "00000",
      "is_use": "1",
      "is_show": "1",
      "cost": "23",
      "quantity": "23",
      "email": "test@gmail.com"
    }
  ];
  List getSlip = [];
  List getCate = [
    {"color": "234,122,322", "name": "Hello"}
  ];
  List sideBar = [
    {"color": "234,122,322", "name": "Hello"}
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Store provider = context.watch<Store>();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: streamData(),
                  ),
                  // topbar
                  Container(
                    color: Colors.grey.shade100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        // Icon...
                      ],
                    ),
                  ),
                  // displays
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('รวมก่อนลด'), Text('200')],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('รวมก่อนลด'),
                                Text(
                                  '200',
                                  style: TextStyle(fontSize: 24),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: err
                                      ? null
                                      : () async {
                                          await promPay();
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              int? selectedRadio = 0;
                                              return payments(size);
                                            },
                                          );
                                        },
                                  child: Text("ชำระเงิน")),
                            )
                          ]),
                    ),
                  ),
                  // list
                  sideBarOrder(size, provider),
                ],
              ),
              // button
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Text(
                              'ลบทั้งหมด',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Text(
                                'คุณต้องการลบสินค้าที่เลือกทั้งหมดหรือไม่'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Slip.deleteAll(
                                        email: provider.email['email']);
                                    setState(() {
                                      priceSum = 0;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'ลบทั้งหมด',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'ยกเลิก',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  )),
                            ]),
                      );
                    },
                    child: Text(
                      'ลบทั้งหมด',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView sideBarOrder(Size size, Store provider) {
    slip(i) {
      // print(getSlip[i]['u_id']);
      return getItem.firstWhere(
          (element) => element['name'] == getSlip[i]['name_item'],
          orElse: () => print('No matching element.'));
    }

    return SingleChildScrollView(
      child: SizedBox(
        height: size.height * .9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: TextButton(
                        child: Text(
                          provider.table == null
                              ? 'เลือกโต๊ะ'
                              : provider.table.toString(),
                          style:
                              const TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        onPressed: () async {
                          await selectTable(provider);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 131, 131),
                                content: SizedBox(
                                  width: size.width * .6,
                                  height: size.height * .7,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              )),
                                          const Text("เลือกโต๊ะ"),
                                          IconButton(
                                              onPressed: () =>
                                                  tableSelect(context),
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.green,
                                              ))
                                        ],
                                      ),
                                      Expanded(
                                          child: table.isNotEmpty
                                              ? GridView.count(
                                                  crossAxisCount: 6,
                                                  children: [
                                                    for (int i = 0;
                                                        i < table.length;
                                                        i++)
                                                      GestureDetector(
                                                        onLongPress: () =>
                                                            TableAPI.delete(
                                                                u_id: table[i]
                                                                    ['u_id']),
                                                        onTap: () {
                                                          setState(() {
                                                            provider.getTable(
                                                                table[i]
                                                                    ['name']);
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Card(
                                                          child: Center(
                                                              child: Text(
                                                                  "${table[i]['name']}")),
                                                        ),
                                                      )
                                                  ],
                                                )
                                              : const Text(''))
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('รวมก่อนลด'),
                              Text('$priceSum')
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('THB'),
                              Text(selled().toString())
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        onPressed: err
                            ? null
                            : () async {
                                await promPay();
                                await showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return payments(size);
                                  },
                                );
                              },
                        child: const Text('ชำระเงิน'))),
                SizedBox(
                  width: double.infinity,
                  height: size.height * .6,
                  child: (getSlip.isNotEmpty &&
                          getItem.isNotEmpty &&
                          slip(0) != null)
                      ? ListView(
                          children: [
                            for (int i = 0; i < getSlip.length; i++)
                              ListTile(
                                  leading: Container(
                                      color: double.tryParse(
                                                  slip(i)['image'][0]) ==
                                              null
                                          ? Colors.red
                                          : readColor(slip(i)['image']),
                                      width: 60,
                                      height: 60,
                                      child: double.tryParse(
                                                  slip(i)['image'][0]) ==
                                              null
                                          ? Image.network(
                                              slip(i)['image'],
                                              fit: BoxFit.cover,
                                            )
                                          : const Text('')),
                                  title: Text(slip(i)['name']),
                                  subtitle: Text(slip(i)['price']),
                                  trailing: GestureDetector(
                                    onTap: () async {
                                      await Slip.delete(
                                          email: provider.email['email'],
                                          u_id: getSlip[i]['u_id']);
                                      await slipSlect();
                                      await sumCheck(i);
                                    },

                                    // print(dSlip(slip(i)['name'])['u_id']),
                                    child: const Icon(
                                      Icons.delete,
                                    ),
                                  )),
                          ],
                        )
                      : const Text(''),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: const Text(
                            'ลบทั้งหมด',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                              'คุณต้องการลบสินค้าที่เลือกทั้งหมดหรือไม่'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  await await Slip.deleteAll(
                                      email: provider.email['email']);
                                  setState(() {
                                    priceSum = 0;
                                  });
                                  await slipSlect();
                                  Navigator.pop(context);
                                  setState(() {
                                    priceSum = 0;
                                  });
                                  await slipSlect();
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'ลบทั้งหมด',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'ยกเลิก',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blue),
                                )),
                          ]),
                    );
                  },
                  child: const Text(
                    'ลบทั้งหมด',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }

  selled() {
    if (amount && sell.text.length > 0 && int.parse(sell.text) > 0) {
      if ((priceSum - int.parse(sell.text)) >= 0) {
        setState(() {
          err = false;
        });
        return priceSum - int.parse(sell.text);
      }
      setState(() {
        err = true;
      });
      return "ส่วนลดมีค่ามากกว่าสินค้า!";
    }
    if (!amount && sell.text.length > 0 && int.parse(sell.text) > 0) {
      if (int.parse(sell.text) <= 100) {
        setState(() {
          err = false;
        });
        return priceSum - (priceSum * (int.parse(sell.text)) / 100);
      }
      setState(() {
        err = true;
      });
      return "ส่วนลดมีค่ามากกว่าสินค้า!";
    } else {
      setState(() {
        err = false;
      });
      return priceSum;
    }
  }

  readColor(res) {
    String rgbSt = res;
    List get = rgbSt.split(",");
    // print("get   $get");
    return Color.fromARGB(
        255, int.parse(get[0]), int.parse(get[1]), int.parse(get[2]));
  }

  // openIcon() {
  //   print(selectByCate());
  //   print(getCate[setSideBar]['name']);
  // }
  promPay() async {
    String res = await GetAPI.genQrProm(name: priceSum.toString());
    setState(() {
      prompayImage = res;
      prompay = true;
    });
  }

  AlertDialog payments(Size size) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: size.width * .5,
            height: size.height * .6,
            child: Column(
              children: [
                // appbar
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text("ชำระเงิน")),
                ),
                Expanded(
                  child: Container(
                      color: Colors.grey.shade100,
                      child: Row(
                        children: [
                          // left
                          Container(
                            color: Colors.grey.shade200,
                            width: 150,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          prompay = true;
                                        });
                                      },
                                      child: Text('ชำระเงินสด')),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          prompay = false;
                                        });
                                      },
                                      child: Text('ชำระพร้อมเพย์')),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                            height: double.infinity,
                            child: !prompay
                                ? Image.memory(base64Decode(prompayImage!))
                                : Text('สด'),
                          ))
                        ],
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  slipSlect() async {
    var req = await http
        .post(Uri.parse("http://$config/mmposAPI/slip_crud.php"), body: {
      "action": "GET_ALL",
      "email": FirebaseAuth.instance.currentUser!.email
    });
    var resSlip = jsonDecode(req.body);
    if (resSlip != getSlip) {
      setState(() {
        getSlip = resSlip;
      });
    }
  }

  selectAll() async {
    if (search.text.length != 0) {
      print(search.text.length);
      await Future<void>.delayed(Duration(hours: 1));
    }
    await Future.delayed(Duration(milliseconds: 482));

    try {
      print("fecting data");
      var request = await http
          .post(Uri.parse('http://$config/mmposAPI/items_crud.php'), body: {
        "action": "GET_ALL",
        "email": FirebaseAuth.instance.currentUser!.email
      });
      var res = jsonDecode(request.body);
      if (res != getItem) {
        setState(() {
          getItem = res;
        });
      }
      // slipCrude

      await slipSlect();
      sumCheck(0);
    } catch (e) {
      print("netwrok is err $e");
    }
  }

  noneStop() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      print("hello there..");
    }
  }

  sumCheck(index) {
    var toint = getSlip.map((e) => int.parse(e['sum'])).toList();
    if (getItem.length != 0 && getSlip.length != 0) {
      priceSum = int.parse(getItem[index]['price']);
    }
    // print(toint);
    priceSum = 0;
    for (int i = 0; i < toint.length; i++) {
      priceSum += toint[i];
    }
  }

  StreamBuilder<dynamic> streamData() {
    return StreamBuilder(
      stream: duration(),
      builder: (context, snapshot) => Expanded(
        child: FutureBuilder(
            future: selectAll(),
            builder: (context, snapshot) => snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text('')),
      ),
    );
  }

  duration() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 8000));
      yield '';
    }
  }

  selectTable(Store provider) async {
    table = await TableAPI.select(provider.email['email']);
    setState(() {
      table = table;
    });
  }

  Future<dynamic> tableSelect(BuildContext context) {
    TextEditingController tableName = TextEditingController();
    Store provider = context.watch<Store>();
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: SingleChildScrollView(
                    child: Column(
                  children: [
                    TextField(
                      controller: tableName,
                    ),
                    OutlinedButton(
                        onPressed: () async {
                          await TableAPI.insertU(
                              name: tableName.text,
                              email: provider.email['email']);
                          await selectTable(provider);
                          Navigator.pop(context);
                        },
                        child: const Text('เพิ่มโต๊ะ'))
                  ],
                )),
              ),
            ));
  }
}
