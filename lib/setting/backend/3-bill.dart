import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';

class BillSetting extends StatefulWidget {
  const BillSetting({super.key});

  @override
  State<BillSetting> createState() => _BillSettingState();
}

class _BillSettingState extends State<BillSetting> {
  bool logo = false;
  bool show_q = false;
  bool show_barcode = false;
  bool auto_bill = false;
  bool auto_order = false;
  XFile? imageSetting;
  List? data;
  //
  int select = 0;
  String type_store = "ใบกำกับภาษี";
  //

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade200,
      //

      //Appbar Start
      appBar: size.width > size.height
          ? null
          : AppBar(
              //
              backgroundColor: Colors.white,
              toolbarHeight: 40,
              //
              leading: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.red,
                            size: 20,
                          ),
                        ],
                      ))
                ],
              ),
              //
              title: Text(
                'ตั้งค่าใบเสร็จรับเงิน',
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              centerTitle: true,
              //
            ),
      //Appbar Stop

      //Body Start

      body: Column(
        children: [
          //Card 1 Start
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Card(
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('พิมพ์โลโก้ร้าน'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: logo,
                          onToggle: (value) {
                            setState(() {
                              logo = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เเสดงคิวบนใบเสร็จ'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: show_q,
                          onToggle: (value) {
                            setState(() {
                              show_q = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เเสดงบาร์โค้ดบนใบเสร็จ'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: show_barcode,
                          onToggle: (value) {
                            setState(() {
                              show_barcode = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('พิมพ์ใบเสร็จอัตโนมัติหลังชำระเงิน'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: auto_bill,
                          onToggle: (value) {
                            setState(() {
                              auto_bill = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('พิมพ์ใบออเดอร์หลังชำระเงิน'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: auto_order,
                          onToggle: (value) {
                            setState(() {
                              auto_order = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('รูปแบบใบเสร็จ'),
                        //
                        SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(3)),
                            width: MediaQuery.of(context).size.width * .6,
                            height: 30,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SelectType(context, 0, 'ใบกำกับภาษี'),
                                  SelectType(context, 1, 'ใบเสร็จรับเงิน'),
                                  SelectType(context, 2, 'กำหนดเอง'),
                                ]),
                          ),
                        )
                        //
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //Card 1 Stop

          //Card 1 Start
          Card(
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ที่อยู่ท้ายบิลบรรทัดที่ 1'),
                      Container(
                        width: 200,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: '',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ที่อยู่ท้ายบิลบรรทัดที่ 2'),
                      Container(
                        width: 200,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: '',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
          //Card 1 Stop

          //Card 2 Start
          Card(
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('รูปภาพท้ายใบเสร็จ 1'),
                      InkWell(
                        onTap: () async {
                          {
                            final newimage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (newimage != null) {
                              final file = newimage;
                              setState(() {
                                imageSetting = file;
                              });
                            } else {
                              return;
                            }
                          }
                        },
                        child: Container(
                          color: Colors.grey.shade200,
                          width: 200,
                          height: 50,
                          child: imageSetting != null
                              ? Image.file(
                                  File(imageSetting!.path),
                                  fit: BoxFit.cover,
                                )
                              : data != null
                                  ? Image.network(
                                      data![0]['image'],
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      CupertinoIcons.photo_on_rectangle,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                        ),
                      )
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('รูปภาพท้ายใบเสร็จ 2'),
                      InkWell(
                        onTap: () async {
                          {
                            final newimage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (newimage != null) {
                              final file = newimage;
                              setState(() {
                                imageSetting = file;
                              });
                            } else {
                              return;
                            }
                          }
                        },
                        child: Container(
                          color: Colors.grey.shade200,
                          width: 200,
                          height: 50,
                          child: imageSetting != null
                              ? Image.file(
                                  File(imageSetting!.path),
                                  fit: BoxFit.cover,
                                )
                              : data != null
                                  ? Image.network(
                                      data![0]['image'],
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      CupertinoIcons.photo_on_rectangle,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                        ),
                      )
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
          //Card 2 Stop

          //TextPreview Button Start

          Card(
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'เเสดงตัวอย่าง',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          )

          //TextPreview Button Stop
        ],
      ),

      //Body Stop
    );
  }

  GestureDetector SelectType(BuildContext context, index, String text1) {
    return GestureDetector(
      onTap: () => setState(() {
        select = index;
        type_store = text1;
      }),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: (MediaQuery.of(context).size.width * .8 / 4) - 6,
          height: double.infinity,
          decoration: BoxDecoration(
              color: select == index ? Colors.white : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(3)),
          child: Center(
              child: Text(
            text1,
            style: TextStyle(fontSize: 13),
          )),
        ),
      ),
    );
  }
}
