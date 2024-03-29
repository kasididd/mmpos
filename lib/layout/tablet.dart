import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;
import 'package:mmpos/API/service_api.dart';
import 'package:mmpos/page/2-main_page.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/screen/7_product_screen.dart';
import 'package:mmpos/src/add-product.dart';
import 'package:mmpos/widget/drawer_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class TabletTable extends StatefulWidget {
  const TabletTable({super.key});

  @override
  State<TabletTable> createState() => _TabletTableState();
}

class _TabletTableState extends State<TabletTable> {
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
    if (getData) {
      selectAll(provider);
    }

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
        toolbarHeight: 50,
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
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(blurRadius: 10, color: Colors.grey.shade300)
              // ],

              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      //
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: SearchField(
                            controller: search,
                            searchInputDecoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.search),
                              hintText: 'ค้นหาสินค้าทั้งหมด...',
                            ),
                            itemHeight: 50,
                            maxSuggestionsInViewPort: 7,
                            suggestionsDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suggestions: getItem
                                .map(
                                  (e) => SearchFieldListItem(e['name'],
                                      item: e['name'],
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(e['name']),
                                      )),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
            ],
          ),
        ),
        //
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: InkWell(
                      onTap: () => searchingByBarcode(),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.red,
                          ),
                          const Text(
                            'รหัสสินค้า',
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.point_of_sale_sharp,
                          color: Colors.red,
                        ),
                        const Text(
                          'เปิดลิ้นชัก',
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: InkWell(
                      onTap: () => coupon(),
                      child: Column(
                        children: [
                          const Icon(
                            CupertinoIcons.tickets,
                            color: Colors.red,
                          ),
                          const Text(
                            'ส่วนลดท้ายบิล',
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 50,
                    child: Column(
                      children: [
                        const Icon(
                          CupertinoIcons.square_arrow_down,
                          color: Colors.red,
                        ),
                        const Text(
                          'พักบิล & เรียกคืน',
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 50,
                    child: InkWell(
                      onTap: () => person(),
                      child: Column(
                        children: [
                          const Icon(
                            CupertinoIcons.person,
                            color: Colors.red,
                          ),
                          const Text(
                            'ลูกค้า',
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      //Appbar Stop

      body: Scaffold(
          body: Row(
        children: [
          //Sildmenu Start

          Container(
            width: MediaQuery.of(context).size.width * 0.08,
            height: double.infinity,
            color: Colors.red,
            child: sideBarItem(size, provider),
          ),

          //Sildmenu Stop

          //Body Start

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: streamData(provider),
                  ),
                ),
                //
                Container(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: 30,
                            child: ElevatedButton(
                                //
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    side: const BorderSide(color: Colors.red)),
                                //
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.barcode_viewfinder,
                                      color: Colors.red,
                                    ),
                                    const Text(
                                      'สแกน',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                )),
                          )
                          //
                        ],
                      )),
                )
                //
              ],
            ),
          ),

          //Body Stop

          //Payment Start

          SizedBox(
              width: MediaQuery.of(context).size.width * 0.17,
              height: double.infinity,
              child: sideBarOrder(size, provider)),

          //Payment Stop
        ],
      )),
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
                                      await slipSlect(provider);
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
                                  await Slip.deleteAll(
                                      email: provider.email['email']);
                                  setState(() {
                                    priceSum = 0;
                                  });
                                  await slipSlect(provider);
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

  AlertDialog payments(Size size) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            width: size.width * .5,
            height: size.height * .6,
            child: Column(
              children: [
                // Appbar Stop
                AppBar(
                  leading: Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 20, // Changing Drawer Icon Size
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                  }),
                  backgroundColor: Colors.white,
                  toolbarHeight: 35,
                  elevation: 0,
                  centerTitle: true,
                  title: const Text(
                    'ชำระเงิน',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ),

                Expanded(
                  child: Container(
                      color: Colors.grey.shade100,
                      child: Row(
                        children: [
                          // left
                          Container(
                            color: Colors.grey.shade200,
                            width: 65,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          prompay = true;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset(
                                                'assets/icons/dollar.png'),
                                          ),
                                          const Text(
                                            'เงินสด',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          prompay = false;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset(
                                                'assets/icons/promtpay-.png'),
                                          ),
                                          const Text(
                                            'คิวอาร์โค้ด',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                          )
                                        ],
                                      )),
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
                onTap: () async => {
                  setState(() => setSideBar = i),
                  cateSelect(provider),
                  await selectAll(provider),
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
                                  u_id: getCate[i]['u_id'],
                                  that_is: "cate");
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
                  child: Card(
                    color: setSideBar == i
                        ? Colors.grey.shade200
                        : readColor(getCate[i]['color']),
                    child: Center(
                        child: Text(
                      getCate[i]['name'],
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              setSideBar == i ? Colors.black87 : Colors.white),
                    )),
                  ),
                ),
              ),
            InkWell(
              onTap: () async => await addCategory(size, provider),
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

  addCategory(Size size, Store provider) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int? selectedRadio = 0;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: List<Widget>.generate(1, (int index) {
                  return SizedBox(
                    width: size.width * .4,
                    height: size.height * .4,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
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
                                      print(colorsPicked);
                                      await Cate.insertU(
                                          provider: provider,
                                          that_is: "cate",
                                          name: nameCate.text,
                                          color:
                                              "${colorsPicked.red},${colorsPicked.green},${colorsPicked.blue}");

                                      await cateSelect(provider);
                                      nameCate.clear();
                                      Navigator.of(context).pop();
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const AlertDialog(
                                            title: Text("โปรดใส่ชื่อ!")),
                                      );
                                    }
                                  },
                                  child: const Text('บันทึก'))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('ชื่อกลุ่มสินค้า'),
                              SizedBox(
                                width: 200,
                                height: 30,
                                child: TextField(
                                  controller: nameCate,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blueAccent),
                                  )),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('เลือกสีพื้นหลัง'),
                              GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (
                                      BuildContext context,
                                    ) {
                                      return AlertDialog(
                                        title: SingleChildScrollView(
                                          child: SizedBox(
                                            width: size.width * .3,
                                            height: size.height * .5,
                                            child: SingleChildScrollView(
                                              child: BlockPicker(
                                                pickerColor: Colors.red,
                                                onColorChanged: (color) {
                                                  setState(() {
                                                    colorsPicked = color;
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                layoutBuilder:
                                                    (context, colors, child) {
                                                  return GridView(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 100,
                                                      childAspectRatio: 1.0,
                                                      crossAxisSpacing: 10,
                                                      mainAxisExtent: 100,
                                                      mainAxisSpacing: 10,
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
                                  height: 50,
                                  color: colorsPicked != null
                                      ? colorsPicked
                                      : Colors.green[600],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              );
            },
          ),
        );
      },
    );
  }

  selectAll(Store provider) async {
    print('ทำงานงาน');
    if (search.text.length != 0) {
      print(search.text.length);
      await Future<void>.delayed(const Duration(hours: 1));
    }
    await Future.delayed(const Duration(milliseconds: 482));

    try {
      var request = await http.post(
          Uri.parse('http://$config/mmposAPI/items_crud.php'),
          body: {"action": "GET_ALL", "email": provider.email['email']});
      var res = jsonDecode(request.body);
      if (res != getItem) {
        if (provider.item == null) {
          provider.getItem(res);
        }
        setState(() {
          getItem = res;
          getData = false;
        });
      }
      // slipCrude

      await slipSlect(provider);
      await cateSelect(provider);
      // print(res);
      sumCheck(0);
    } catch (e) {
      print("netwrok is err $e");
    }
  }

  slipSlect(provider) async {
    var req = await http
        .post(Uri.parse("http://$config/mmposAPI/slip_crud.php"), body: {
      "action": "GET_ALL",
      "email": provider.email['email'],
      "that_is": "cate"
    });
    var resSlip = jsonDecode(req.body);
    if (resSlip != getSlip) {
      setState(() {
        getSlip = resSlip;
        print(getSlip);
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
                                crossAxisCount: 5, childAspectRatio: 0.85),
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
                                        flex: 5,
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
    if (getItem.length != 0 && getSlip.length != 0) {
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
        // print(response.body);
        var res = jsonDecode(response.body);
        if (res.isNotEmpty) {
          setState(() {
            getCate = res;
            provider.getCate(getCate);
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
    print("openIcon");
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
                  onChanged: (value) async => await selled(),
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
                GestureDetector(
                  child: SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 4 / 2,
                        children: [
                          InkWell(
                            onTap: () async {
                              setState(
                                () => amount = false,
                              );
                              {
                                sell.value = const TextEditingValue(text: "23");
                                await selled();
                              }
                            },
                            child: const Card(
                              color: Colors.redAccent,
                              child: Center(child: Text('ลด10%')),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              setState(
                                () => amount = false,
                              );
                              {
                                sell.value = const TextEditingValue(text: "10");
                                await selled();
                              }
                            },
                            child: const Card(
                              color: Colors.redAccent,
                              child: Center(child: Text('ลด10%')),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              setState(
                                () => amount = false,
                              );
                              {
                                sell.value = const TextEditingValue(text: "15");
                                await selled();
                              }
                            },
                            child: const Card(
                              color: Colors.redAccent,
                              child: Center(child: Text('ลด15%')),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              setState(
                                () => amount = false,
                              );
                              {
                                sell.value = const TextEditingValue(text: "20");
                                await selled();
                              }
                            },
                            child: const Card(
                              color: Colors.redAccent,
                              child: Center(child: Text('ลด20%')),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              setState(
                                () => amount = false,
                              );
                              {
                                sell.value = const TextEditingValue(text: "50");
                                await selled();
                              }
                            },
                            child: const Card(
                              color: Colors.redAccent,
                              child: Center(child: Text('ลด50%')),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            )),
          ),
        ),
        actions: [
          OutlinedButton(
              onPressed: () => {Navigator.pop(context)},
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
                              await dialogAddCustomer(context);
                            },
                            child: const Icon(Icons.add)))
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
                          hintText: 'ค้นหาสินค้าทั้งหมด...',
                        ),
                        itemHeight: 50,
                        maxSuggestionsInViewPort: 7,
                        suggestionsDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suggestions: getItem
                            .map(
                              (e) => SearchFieldListItem(e['name'],
                                  item: e['name'],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(e['name']),
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
                child: ListView(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
                      title: const Text("name"),
                      trailing: const Text("0985757375"),
                    )
                  ],
                ),
              )
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
                      const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const Text('ชื่อลูกค้า'),
                const TextField(
                  decoration: InputDecoration(hintText: "กรอกชื่อ"),
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
                              if (!sex[i]['check'])
                                setState(() {
                                  sex
                                      .map((e) => e['check'] = sex[i]['check'])
                                      .toList();
                                  sex[i]['check'] = !sex[i]['check'];
                                });
                            },
                          ),
                          Text(sex[i]['label']),
                        ],
                      ),
                  ],
                ),
                const TextField(
                  decoration: InputDecoration(hintText: "กรอกนามสกุล"),
                ),
                const Text("เบอร์โทร"),
                const TextField(
                  decoration: InputDecoration(hintText: "ex.0982344***"),
                ),
                InkWell(
                  onTap: () => dialogGroup(context),
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
          content: StatefulBuilder(
            builder: (context, setState) => Container(
              child: SizedBox(
                width: 300,
                height: MediaQuery.of(context).size.height * .6,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        const Text("เลือกกลุ่มลูกค้า"),
                        const Icon(Icons.add)
                      ],
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Container(
                              color: Colors.grey.shade100,
                              child: ListTile(
                                leading: ClipOval(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.red,
                                    child: const Center(
                                      child: Text(
                                        "N",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                ),
                                title: const Text("name"),
                              ),
                            ),
                          )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  duration() async* {
    while (onStream) {
      await Future.delayed(const Duration(seconds: 1));
      yield '';
    }
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

  selectTable(Store provider) async {
    table = await TableAPI.select(provider.email['email']);
    setState(() {
      table = table;
    });
  }
}
