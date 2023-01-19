import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mmpos/API/service_api.dart';
import 'package:http/http.dart' as http;
import 'package:mmpos/layout/phone_payment.dart';
import 'package:mmpos/models/phone_payment.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/screen/7_product_screen.dart';
import 'package:mmpos/src/add-product.dart';
import 'package:mmpos/widget/drawer_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class PhoneTable extends StatefulWidget {
  const PhoneTable({super.key});

  @override
  State<PhoneTable> createState() => _PhoneTableState();
}

class _PhoneTableState extends State<PhoneTable> {
  int sumAll = 0;
  TextEditingController val = TextEditingController();
  bool checkOpen = true;
  bool err = false;
  bool barcode = false;
  bool amount = false;
  bool onStream = true;

  List table = [];
  List rgb = ["156", "39", "176"];
  String rgbSt = "156, 39, 176";
  TextEditingController nameCate = TextEditingController();
  TextEditingController searcBarcode = TextEditingController();
  var sell = TextEditingController();
  TextEditingController search = TextEditingController();
  String? prompayImage;
  String? grSlect;
  bool prompay = true;
  int setSideBar = 0;
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
  List grCustomer = [];
  List customerInfo = [];
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
    if (checkOpen) selectAll(provider);
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade200,
      //
      drawer: DrawerWidget(
        provider: provider,
      ),
      //Appbar Start
      appBar: AppBar(
        //
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        //
        leading: Builder(
          builder: (context) => // Ensure Scaffold is in context
              IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.red,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer()),
        ),
        //
        title: Container(
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(blurRadius: 10, color: Colors.grey.shade300)
              // ],
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 20,
                    ),
                    //
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'ค้นหาสินค้าทั้งหมด',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              //
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.qr_code_scanner_sharp,
                    color: Colors.red,
                    size: 20,
                  ))
            ],
          ),
        ),
        //
        actions: [
          IconButton(
              onPressed: () {
                //
                showCupertinoModalBottomSheet(
                  expand: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const SearchWidget(),
                );
                //
              },
              icon: const Icon(
                Icons.search,
                color: Colors.red,
              ))
        ],
      ),
      //Appbar Stop

      //
      body: Column(
        children: [
          //Table

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              //
              width: double.infinity,
              height: 30,
              //
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100,
                      side: const BorderSide(color: Colors.red)),
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
                                        onPressed: () => Navigator.pop(context),
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        )),
                                    const Text("เลือกโต๊ะ"),
                                    IconButton(
                                        onPressed: () => tableSelect(context),
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.green,
                                        ))
                                  ],
                                ),
                                Expanded(
                                    child: table.isNotEmpty
                                        ? GridView.count(
                                            crossAxisCount: 3,
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
                                                          table[i]['name']);
                                                    });
                                                    Navigator.pop(context);
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
                  child: const Text('เลือกโต๊ะ')),
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: sideBarItem(size, provider),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: streamData(provider),
                ),
              ),
            ],
          )),

          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  //
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  //
                  onPressed: () {
                    //
                    showCupertinoModalBottomSheet(
                      expand: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const ProductAdd(),
                    );
                    //
                  },
                  child: InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Old())),
                    child: Row(
                      //
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //
                      children: const [
                        Text('ตะกร้า 0 รายการ'),
                        Text('THB 0.00'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //
        ],
      ),
      //
    );
  }

  Future<dynamic> tableSelect(BuildContext context) {
    Store provider = context.watch<Store>();
    TextEditingController tableName = TextEditingController();
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

  InkWell iconTop(icon, name, func) {
    return InkWell(
      onTap: () => func(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.red,
              size: 30,
            ),
            Text(
              '$name',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  AlertDialog payments(Size size) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            width: size.width * .5,
            height: size.height * .6,
            child: Column(
              children: [
                // appbar
                const SizedBox(
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
                                      child: const Text('ชำระเงินสด')),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          prompay = false;
                                        });
                                      },
                                      child: const Text('ชำระพร้อมเพย์')),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                            height: double.infinity,
                            child: !prompay
                                ? Image.memory(base64Decode(prompayImage!))
                                : const Text('สด'),
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

// sideBarItem mian1
  Container sideBarItem(Size size, Store provider) {
    return Container(
      color: Colors.transparent,
      width: size.width * .1,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < getCate.length; i++)
              InkWell(
                onTap: () => {
                  setState(() => setSideBar = i),
                  cateSelect(provider),
                  searcBarcode.clear()
                },
                onLongPress: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('ต้องการลบ cate gory?'),
                    actions: [
                      OutlinedButton(
                          onPressed: () async {
                            if (getCate.length > 1) {
                              setState(() {
                                if (setSideBar != 0) {
                                  setSideBar = setSideBar - 1;
                                } else {
                                  if (setSideBar.bitLength > 1) {
                                    setSideBar = setSideBar + 1;
                                  }
                                }
                              });
                              await Cate.delete(
                                  provider: provider,
                                  that_is: "cate",
                                  u_id: getCate[i]['u_id']);
                              await cateSelect(provider);
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                  title: Text(
                                    'Category ไม่สามารถน้อยกว่า 1 !',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.red),
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "ยืนยัน",
                            style: TextStyle(color: Colors.red),
                          )),
                      OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("ยกเลิก")),
                    ],
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: provider.cate.isEmpty
                      ? const Card(
                          child: Text("กรุณาเพิ่ม Category"),
                        )
                      : Card(
                          color: setSideBar == i
                              ? Colors.grey.shade200
                              : readColor(provider.cate[i]['color']),
                          child: Center(
                              child: Text(
                            provider.cate[i]['name'],
                            style: TextStyle(
                                fontSize: 16,
                                color: setSideBar == i
                                    ? Colors.black87
                                    : Colors.white),
                          )),
                        ),
                ),
              ),
            InkWell(
              onTap: () async => await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SingleChildScrollView(
                          child: Column(
                            children: List<Widget>.generate(1, (int index) {
                              return SizedBox(
                                width: size.width,
                                height: size.height * .7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              icon: const Icon(Icons.close)),
                                          const Text('เพิ่มกลุ่มสินค้า'),
                                          TextButton(
                                              onPressed: () async {
                                                if (nameCate.text.isNotEmpty) {
                                                  print(nameCate.text);
                                                  sideBar.add({
                                                    "color":
                                                        "${colorsPicked.red},${colorsPicked.green},${colorsPicked.blue}",
                                                    "name": nameCate.text
                                                  });
                                                  await Cate.insertU(
                                                      provider: provider,
                                                      name: nameCate.text,
                                                      that_is: "cate",
                                                      color:
                                                          "${colorsPicked.red},${colorsPicked.green},${colorsPicked.blue}");
                                                  nameCate.clear();

                                                  await cateSelect(provider);
                                                  Navigator.of(context).pop();
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        const AlertDialog(
                                                            title: Text(
                                                                "โปรดใส่ชื่อ!")),
                                                  );
                                                }
                                              },
                                              child: const Text('บันทึก'))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: size.width * .5,
                                            height: 40,
                                            child: TextField(
                                              controller: nameCate,
                                              decoration: const InputDecoration(
                                                  hintText: "ชื่อกลุ่มสินค้า",
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 3,
                                                        color:
                                                            Colors.blueAccent),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('เลือกสีพื้นหลัง'),
                                          GestureDetector(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder: (
                                                  BuildContext context,
                                                ) {
                                                  return AlertDialog(
                                                    title:
                                                        SingleChildScrollView(
                                                      child: SizedBox(
                                                        width: size.width * .3,
                                                        height:
                                                            size.height * .5,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: BlockPicker(
                                                            pickerColor:
                                                                Colors.red,
                                                            onColorChanged:
                                                                (color) {
                                                              setState(() {
                                                                colorsPicked =
                                                                    color;
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            layoutBuilder:
                                                                (context,
                                                                    colors,
                                                                    child) {
                                                              return GridView(
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                gridDelegate:
                                                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                                                  maxCrossAxisExtent:
                                                                      100,
                                                                  childAspectRatio:
                                                                      1.0,
                                                                  crossAxisSpacing:
                                                                      10,
                                                                  mainAxisExtent:
                                                                      100,
                                                                  mainAxisSpacing:
                                                                      10,
                                                                ),
                                                                children: [
                                                                  for (Color color
                                                                      in colors)
                                                                    child(color)
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            child: Container(
                                                width: 50,
                                                height: 30,
                                                color: colorsPicked),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('เปิดใช้งาน'),
                                          SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: Switch(
                                                value: onOff,
                                                onChanged: (value) {
                                                  setState(() {
                                                    onOff = !onOff;
                                                  });
                                                },
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  color: Colors.white,
                  child: Icon(
                    Icons.add,
                    color: Colors.grey.shade400,
                    size: 40,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  selectAll(Store provider) async {
    print('object');
    if (search.text.isNotEmpty) {
      print(search.text.length);
      await Future<void>.delayed(const Duration(hours: 1));
    }
    await Future.delayed(const Duration(milliseconds: 482));

    try {
      var request = await http.post(
          Uri.parse('http://$config/mmposAPI/items_crud.php'),
          body: {"action": "GET_ALL", "email": provider.email['email']});
      List res = jsonDecode(request.body);
      if (res.isNotEmpty) {
        setState(() {
          getItem = res;
          print(provider.cate);
        });
      }
      // slipCrude
      await cateSelect(provider);
      await slipSlect(provider);
      await sumCheck(0);
      setState(() {
        provider.getItem(getItem);
        provider.getCate(getCate);
        checkOpen = false;
      });
    } catch (e) {
      print("netwrok is err $e");
    }
  }

  slipSlect(Store provider) async {
    var req = await http.post(
        Uri.parse("http://$config/mmposAPI/slip_crud.php"),
        body: {"action": "GET_ALL", "email": provider.email['email']});
    var resSlip = jsonDecode(req.body);
    if (resSlip != getSlip) {
      setState(() {
        getSlip = resSlip;
      });
    }
  }

  selectByCate() {
    if (getCate.isNotEmpty) {
      if (searcBarcode.text.isNotEmpty) {
        if (getItem
            .where((element) => element['items_barcode'] == searcBarcode.text)
            .isNotEmpty) {
          return getItem
              .where((element) => element['items_barcode'] == searcBarcode.text)
              .toList();
        }
        return [];
      } else {
        if (getItem
            .where(
                (element) => element['category'] == getCate[setSideBar]['name'])
            .isNotEmpty) {
          return getItem
              .where((element) =>
                  element['category'] == getCate[setSideBar]['name'])
              .toList();
        }
        return [];
      }
    }
  }

// main2
  FutureBuilder<dynamic> streamData(Store provider) {
    return FutureBuilder(
        builder: (context, snapshot) => snapshot.hasData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                child: getItem.isNotEmpty && selectByCate().length >= 0
                    ? GridView.builder(
                        itemCount: selectByCate().length + 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.75),
                        itemBuilder: (context, index) => selectByCate()
                                        .length ==
                                    index ||
                                selectByCate().length == 0
                            ? InkWell(
                                onTap: () async {
                                  provider.addCate(getCate);
                                  await showBarModalBottomSheet(
                                    expand: true,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => const ProductScreen(),
                                  );
                                },
                                child: const Card(
                                  color: Colors.white,
                                  child: Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  print('object');
                                  await Slip.insertU(
                                      email: provider.email['email'],
                                      name_item: selectByCate()[index]['name'],
                                      sum: selectByCate()[index]['price']);
                                  await slipSlect(provider);
                                  await sumCheck(index);
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          color: double.tryParse(
                                                      selectByCate()[index]
                                                          ['image'][0]) ==
                                                  null
                                              ? Colors.red
                                              : readColor(selectByCate()[index]
                                                  ['image']),
                                          width: double.infinity,
                                          height: 130,
                                          child: double.tryParse(
                                                      selectByCate()[index]
                                                          ['image'][0]) ==
                                                  null
                                              ? Image.network(
                                                  selectByCate()[index]
                                                      ['image'],
                                                  fit: BoxFit.cover,
                                                )
                                              : const Text(''),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Text(selectByCate()[index]['name']),
                                            Text(
                                                selectByCate()[index]['price']),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      )
                    : const Center(child: Text('')),
              ));
  }

//
  Padding iconAppBar(
      {required String text, required var getIcon, required bool checkTable}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: !checkTable ? 15.0 : 2),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getIcon,
              color: Colors.green.shade200,
              size: !checkTable ? 30 : 20,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.green.shade400),
            )
          ],
        ),
      ),
    );
  }
//

  duration() async* {
    while (onStream) {
      await Future.delayed(const Duration(seconds: 1));
      yield '';
    }
  }

  promPay() async {
    String res = await GetAPI.genQrProm(name: priceSum.toString());
    print(sumAll.toString());
    setState(() {
      prompayImage = res;
      prompay = true;
    });
  }

  sumCheck(index) {
    var toint = getSlip.map((e) => int.parse(e['sum'])).toList();
    if (getItem.isNotEmpty && getSlip.isNotEmpty) {
      priceSum = int.parse(getItem[index]['price']);
    }
    // print(toint);
    priceSum = 0;
    for (int i = 0; i < toint.length; i++) {
      priceSum += toint[i];
    }
  }

  cateSelect(Store provider) async {
    try {
      var response = await http.post(Uri.parse(cateLink), body: {
        "action": "GET_ALL",
        "email": provider.email['email'],
        "that_is": "cate"
      });
      if (response.statusCode == 200) {
        List res = jsonDecode(response.body);
        // print(response.body);
        if (res.isNotEmpty) {
          setState(() {
            getCate = res;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  readColor(res) {
    String rgbSt = res;
    List get = rgbSt.split(",");
    // print("get   $get");
    return Color.fromARGB(
        255, int.parse(get[0]), int.parse(get[1]), int.parse(get[2]));
  }

  openIcon() {
    print(selectByCate());
    print(getCate[setSideBar]['name']);
  }

  searchingByBarcode() {
    print("searchingByBarcode");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
            child: Column(
          children: [
            const Text('ค้นหาด้วยรหัสสินค้า'),
            TextField(
              controller: searcBarcode,
              keyboardType: TextInputType.number,
            )
          ],
        )),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('เรียบร้อย'))
        ],
      ),
    );
  }

  coupon() {
    var size = MediaQuery.of(context).size;
    print("searchingByBarcode");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: StatefulBuilder(
          builder: (context, setState) => SizedBox(
            width: size.width * .4,
            height: size.height * .6,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.green,
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        barcode = false;
                      }),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28.0, vertical: 10),
                          child: Text(
                            'ส่วนลด',
                            style: TextStyle(
                                color: barcode ? Colors.black87 : Colors.green),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        barcode = true;
                      }),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28.0, vertical: 10),
                          child: Text(
                            'แสกนบาร์โค๊ด/QR code',
                            style: TextStyle(
                                color:
                                    !barcode ? Colors.black87 : Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.grey.shade200,
                  width: double.infinity,
                  height: 2,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "จำนวนเงิน"),
                  controller: sell,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => setState(() {
                              amount = true;
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: amount
                                      ? Colors.white
                                      : Colors.transparent),
                              child: const Center(child: Text('Amount')),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => setState(() {
                              amount = false;
                            }),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: !amount
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                                child: const Center(child: Text('%'))),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 4 / 2,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(
                              () => amount = false,
                            );
                            sell.value = const TextEditingValue(text: "23");
                          },
                          child: const Card(
                            color: Colors.redAccent,
                            child: Center(child: Text('ลด10%')),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(
                              () => amount = false,
                            );
                            sell.value = const TextEditingValue(text: "10");
                          },
                          child: const Card(
                            color: Colors.redAccent,
                            child: Center(child: Text('ลด10%')),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(
                              () => amount = false,
                            );
                            sell.value = const TextEditingValue(text: "15");
                          },
                          child: const Card(
                            color: Colors.redAccent,
                            child: Center(child: Text('ลด15%')),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(
                              () => amount = false,
                            );
                            sell.value = const TextEditingValue(text: "20");
                          },
                          child: const Card(
                            color: Colors.redAccent,
                            child: Center(child: Text('ลด20%')),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(
                              () => amount = false,
                            );
                            sell.value = const TextEditingValue(text: "50");
                          },
                          child: const Card(
                            color: Colors.redAccent,
                            child: Center(child: Text('ลด50%')),
                          ),
                        ),
                      ],
                    ))
              ],
            )),
          ),
        ),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('เรียบร้อย'))
        ],
      ),
    );
  }

  selled() {
    if (amount && sell.text.isNotEmpty && int.parse(sell.text) > 0) {
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
    if (!amount && sell.text.isNotEmpty && int.parse(sell.text) > 0) {
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

  person() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
            child: SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          height: MediaQuery.of(context).size.height * .6,
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 60,
                        height: double.infinity,
                        child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Center(child: Text('ปิด')))),
                    const Text('ค้นหาสมาชิก'),
                    SizedBox(
                        width: 60,
                        height: double.infinity,
                        child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              await await grSelect();
                              await dialogAddCustomer(context);
                            },
                            child: const Icon(Icons.edit)))
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    Expanded(
                      child: SearchField(
                        controller: search,
                        searchInputDecoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
                          hintText: 'ค้นหาด้วยเบอร์...',
                        ),
                        itemHeight: 50,
                        maxSuggestionsInViewPort: 7,
                        suggestionsDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suggestions: customerInfo
                            .map(
                              (e) => SearchFieldListItem(e['tel'],
                                  item: e['tel'],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(e['tel']),
                                  )),
                            )
                            .toList(),
                      ),
                    ),
                    const Icon(Icons.qr_code)
                  ],
                ),
              ),
              Expanded(
                  child: customerInfo.isNotEmpty
                      ? ListView.builder(
                          itemCount: customerInfo.length,
                          itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  leading: ClipOval(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(
                                          customerInfo[index]['fname'][0],
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                      "${customerInfo[index]['fname']}   ${customerInfo[index]['fname']}"),
                                  trailing:
                                      Text("${customerInfo[index]['tel']}"),
                                ),
                              ))
                      : const Text(''))
            ],
          ),
        )),
      ),
    );
  }

  Future<dynamic> dialogAddCustomer(BuildContext context) {
    List sex = [
      {
        "check": false,
        "label": "ชาย",
      },
      {
        "check": false,
        "label": "หญิง",
      },
      {
        "check": true,
        "label": "ไม่ระบุเพศ",
      },
    ];
    bool colorCheck = false;
    TextEditingController fname = TextEditingController();
    TextEditingController lname = TextEditingController();
    TextEditingController tel = TextEditingController();
    Store provider = context.watch<Store>();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.close),
                      const Text('เพิ่มข้อมูลลูกค้า'),
                      GestureDetector(
                        onTap: () => grSlect != null &&
                                fname.text.isNotEmpty &&
                                tel.text.isNotEmpty &&
                                lname.text.isNotEmpty
                            ? CustomerAPI().insertU(
                                bday: "",
                                email: provider.email['email'],
                                fname: fname.text,
                                lname: lname.text,
                                tel: tel.text,
                                sex: sex
                                    .firstWhere((element) =>
                                        element['check'] == true)['label']
                                    .toString(),
                                c_group: grSlect!)
                            : null,
                        child: Icon(
                          Icons.check,
                          color: grSlect != null &&
                                  fname.text.isNotEmpty &&
                                  tel.text.isNotEmpty &&
                                  lname.text.isNotEmpty &&
                                  colorCheck
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('ชื่อลูกค้า'),
                TextField(
                  controller: fname,
                  decoration: const InputDecoration(hintText: "กรอกชื่อ"),
                ),
                const Text('นามสกุลลูกค้า'),
                const Text('เพศ'),
                Row(
                  children: [
                    for (int i = 0; i < sex.length; i++)
                      Column(
                        children: [
                          Checkbox(
                            value: sex[i]['check'],
                            onChanged: (value) async {
                              setState(() {
                                for (int j = 0; j < sex.length; j++) {
                                  sex[j]['check'] = false;
                                }
                                sex[i]['check'] = true;
                              });
                            },
                          ),
                          Text(sex[i]['label']),
                        ],
                      ),
                  ],
                ),
                TextField(
                  controller: lname,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "กรอกนามสกุล"),
                ),
                const Text("เบอร์โทร"),
                TextField(
                  controller: tel,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "ex.0982344***"),
                ),
                InkWell(
                  onTap: () =>
                      {setState(() => colorCheck = true), dialogGroup(context)},
                  child: const SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Card(
                      child: Center(child: Text("กลุ่มลูกค้า")),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> dialogGroup(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(builder: (context, setState) {
            Store provider = context.watch<Store>();
            return Container(
              child: SizedBox(
                width: 300,
                height: MediaQuery.of(context).size.height * .6,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close)),
                        const Text("เลือกกลุ่มลูกค้า"),
                        IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: TextField(
                                controller: nameCate,
                                decoration: const InputDecoration(
                                    hintText: "ใส่ชื่อกลุ่มลูกค้า"),
                              ),
                              actions: [
                                OutlinedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("ยกเลิก")),
                                OutlinedButton(
                                    onPressed: () async => {
                                          await Cate.insertU(
                                              provider: provider,
                                              color: "",
                                              name: nameCate.text,
                                              that_is: "gr.customer"),
                                          nameCate.clear(),
                                          await grSelect(),
                                          Navigator.pop(context)
                                        },
                                    child: const Text('สร้างกลุ่ม'))
                              ],
                            ),
                          ),
                          icon: const Icon(Icons.add),
                          color: Colors.green,
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        for (int i = 0; i < grCustomer.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Container(
                              color: Colors.grey.shade100,
                              child: GestureDetector(
                                onTap: () => {
                                  setState(
                                      () => grSlect = grCustomer[i]['name']),
                                  Navigator.pop(context)
                                },
                                child: ListTile(
                                  leading: ClipOval(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.blue.shade300,
                                      child: Center(
                                        child: Text(
                                          grCustomer[i]['name'][0],
                                          style: const TextStyle(fontSize: 30),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(grCustomer[i]['name']),
                                ),
                              ),
                            ),
                          )
                      ],
                    ))
                  ],
                ),
              ),
            );
          }),
        ),
      );
  grSelect() async {
    try {
      print('go');
      var response = await http.post(Uri.parse(cateLink), body: {
        "action": "GET_ALL",
        "email": " FirebaseAuth.instance.currentUser!.email.toString()",
        "that_is": "gr.customer"
      });
      if (response.statusCode == 200) {
        // print(response.body);
        setState(() {
          grCustomer = jsonDecode(response.body);
          print(grCustomer);
        });
      }
      print('go customer');
      var req = await http.post(Uri.parse(customerLink), body: {
        "action": "GET_ALL",
        "email": "FirebaseAuth.instance.currentUser!.email.toString()",
      });
      if (req.statusCode == 200) {
        // print(req.body);
        setState(() {
          customerInfo = jsonDecode(req.body);
          print(customerInfo);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  selectTable(Store provider) async {
    table = await TableAPI.select(provider.email['email']);
    setState(() {
      table = table;
    });
  }
}

//Search Start

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade300,
      //
      appBar: AppBar(
        //
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        //
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            )),
        //
        title: const Text(
          'ค้นหาด้วยรหัสสินค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
      ),
      //
    );
  }
}

//Search Stop