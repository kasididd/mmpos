import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  bool user = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade200,
      //

      //Appbar Start
      appBar: AppBar(
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
          'พนักงาน',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
        actions: [
          TextButton(
              onPressed: () {
                //
                showCupertinoModalBottomSheet(
                  expand: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => addUser(),
                );
                //
              },
              child: Text(
                'เพิ่มพนักงาน',
                style: TextStyle(color: Colors.red, fontSize: 13),
              ))
        ],
      ),
      //Appbar Stop

      //

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ระบบพนักงาน'),
                    //Switch Start
                    FlutterSwitch(
                      height: 20.0,
                      width: 40.0,
                      padding: 4.0,
                      toggleSize: 15.0,
                      borderRadius: 10.0,
                      activeColor: Colors.red,
                      value: user,
                      onToggle: (value) {
                        setState(() {
                          user = value;
                        });
                      },
                    ),
                    //Switch Stop
                  ],
                ),
              ),
            ),
          )
        ],
      ),

      //
    );
  }
}

//

class addUser extends StatefulWidget {
  const addUser({super.key});

  @override
  State<addUser> createState() => _addUserState();
}

class _addUserState extends State<addUser> {
  bool prem1 = false;
  bool prem2 = false;
  bool prem3 = false;
  bool prem4 = false;
  bool prem5 = false;
  bool prem6 = false;
  bool prem7 = false;
  bool prem8 = false;
  bool prem9 = false;
  bool prem10 = false;
  bool prem11 = false;
  bool prem12 = false;
  bool prem13 = false;
  bool prem14 = false;
  bool prem15 = false;
  bool prem16 = false;
  bool prem17 = false;
  //
  XFile? imageUser;
  List? data;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade300,
      //

      //Appbar Start

      appBar: AppBar(
        //
        backgroundColor: Colors.white,
        toolbarHeight: 45,
        //
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: Colors.red,
            )),
        //
        title: Text(
          'เพิ่มพนักงาน',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'บันทึก',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      //Appbar Stop

      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              //
              elevation: 0,
              //
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          {
                            final newimage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (newimage != null) {
                              final file = newimage;
                              setState(() {
                                imageUser = file;
                              });
                            } else {
                              return;
                            }
                          }
                        },
                        child: Container(
                          color: Colors.grey.shade200,
                          width: 50,
                          height: 50,
                          child: imageUser != null
                              ? Image.file(
                                  File(imageUser!.path),
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
                  //
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ชื่อพนักงาน'),
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
                        Text('รหัสผ่าน'),
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
            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('ROLES')],
              ),
            ),
            //
            Card(
              //
              elevation: 0,
              //
              child: Column(
                children: [
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('จัดการสินค้า'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem1,
                          onToggle: (value) {
                            setState(() {
                              prem1 = value;
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
                        Text('จัดการบิล'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem2,
                          onToggle: (value) {
                            setState(() {
                              prem2 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ยกเลิกการขาย'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem3,
                          onToggle: (value) {
                            setState(() {
                              prem3 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('จัดการคลังสินค้า'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem4,
                          onToggle: (value) {
                            setState(() {
                              prem4 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เรียกดูรายงาน'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem5,
                          onToggle: (value) {
                            setState(() {
                              prem5 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ลูกค้า'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem6,
                          onToggle: (value) {
                            setState(() {
                              prem6 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('การตั้งค่า'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem7,
                          onToggle: (value) {
                            setState(() {
                              prem8 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เปิดลิ้นชักเก็บเงิน'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem9,
                          onToggle: (value) {
                            setState(() {
                              prem9 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('พนักงาน'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem10,
                          onToggle: (value) {
                            setState(() {
                              prem10 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('แสดงกำไรที่ได้'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem12,
                          onToggle: (value) {
                            setState(() {
                              prem12 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ),
            //
            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('INVENTORY ACCESS')],
              ),
            ),
            //
            Card(
              //
              elevation: 0,
              //
              child: Column(
                children: [
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('สร้างเอกสารรับเข้า'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem13,
                          onToggle: (value) {
                            setState(() {
                              prem13 = value;
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
                        Text('แก้ไขเอกสารรับเข้า'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem14,
                          onToggle: (value) {
                            setState(() {
                              prem14 = value;
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
                        Text('สร้างเอกสารจ่ายออก'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem15,
                          onToggle: (value) {
                            setState(() {
                              prem15 = value;
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
                        Text('แก้ไขเอกสารจ่ายออก'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem16,
                          onToggle: (value) {
                            setState(() {
                              prem16 = value;
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
                        Text('ปรับปรุงสต๊อก'),
                        //Switch Start
                        FlutterSwitch(
                          height: 20.0,
                          width: 40.0,
                          padding: 4.0,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          activeColor: Colors.red,
                          value: prem17,
                          onToggle: (value) {
                            setState(() {
                              prem17 = value;
                            });
                          },
                        ),
                        //Switch Stop
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
