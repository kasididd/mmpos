import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmpos/API/service_api.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/src/round/round_setting.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ShopSetting extends StatefulWidget {
  const ShopSetting({
    super.key,
  });
  @override
  State<ShopSetting> createState() => _ShopSettingState();
}

class _ShopSettingState extends State<ShopSetting> {
  List data = [[]];
  bool tax = false;
  bool bill = false;
  XFile? imageSetting;
  String? imageAdd;
  String? image;
  String type_store = "ร้านค้าทั่วไป";
  TextEditingController name = TextEditingController(text: "MMPOS");
  TextEditingController tax_id = TextEditingController();
  TextEditingController pos_id = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController m_id = TextEditingController();
  TextEditingController time_open = TextEditingController();
  TextEditingController time_close = TextEditingController();
  TextEditingController tax_val = TextEditingController();
  TextEditingController service_chage = TextEditingController();
  TextEditingController adress1 = TextEditingController();
  TextEditingController adress2 = TextEditingController();
  TextEditingController tel = TextEditingController();
  int is_doble = 0;
  bool check = true;
  int select = 0;
  XFile? imagePicked;

  //

  //

  //
  Future<void> uploadImage() async {
    try {
      List<int> imageBytes =
          File(imagePicked!.path.toString()).readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      // print('$imageName');
      imageAdd = "${name.text}.${imagePicked!.path.split('.').last}";
      var response = await http.post(
          Uri.parse('http://$config/mmposAPI/crud_mmpos.php'),
          body: {'image': baseimage, 'name': imageAdd});
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          image = "http://$config/mmposAPI/image/$imageAdd";
        });
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Store provider = context.watch<Store>();
    if (check) getData(provider);
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
                          const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.red,
                            size: 20,
                          ),
                        ],
                      ))
                ],
              ),
              //
              title: const Text(
                'ตั้งค่าร้านค้า',
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              centerTitle: true,
              //
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    onPressed: () async {
                      await uploadImage();
                      if (image != null ||
                          data[0]['image'].length > 10 &&
                              type_store != null &&
                              tax_id.text.isNotEmpty &&
                              pos_id.text.isNotEmpty &&
                              branch.text.isNotEmpty &&
                              m_id.text.isNotEmpty &&
                              time_open.text.isNotEmpty &&
                              time_close.text.isNotEmpty &&
                              tax_val.text.isNotEmpty &&
                              service_chage.text.isNotEmpty &&
                              adress1.text.isNotEmpty &&
                              adress2.text.isNotEmpty &&
                              tel.text.isNotEmpty &&
                              name.text.isNotEmpty &&
                              tel.text.isNotEmpty) {
                        String adress1_2 = "${adress1.text},${adress2.text}";
                        await UserStore.update(
                          email: provider.email['email'],
                          setting: type_store,
                          u_id: data[0]['u_id'],
                          image: image != null ? image : data[0]['image'],
                          type_store: select.toString(),
                          tax_id: tax_id.text,
                          pos_id: pos_id.text,
                          branch: branch.text,
                          m_id: m_id.text,
                          time_open: time_open.text,
                          time_close: time_close.text,
                          tax_val: tax_val.text,
                          service_chage: service_chage.text,
                          is_doble: is_doble.toString(),
                          adress1_2: adress1_2,
                          tel: tel.text,
                          name_store: name.text,
                          tel_promt: tel.text,
                        );
                        await getData(provider);
                        await showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                              title: Text(
                            "สำเร็จ!",
                            style: TextStyle(fontSize: 24),
                          )),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                              title: Text(
                            "กรุณาใส่ข้อมูลให้ครบ!",
                            style: TextStyle(fontSize: 24),
                          )),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.save,
                      size: 40,
                    ),
                    color: Colors.green,
                  ),
                )
              ],
            ),
      //Appbar Stop

      //Body Start

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('โลโก้'),
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
                                          data[0]['image'],
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
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

                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('ชื่อร้าน'),
                          Container(
                            width: 200,
                            height: 40,
                            child: TextField(
                              controller: name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('ประเภทร้านค้า'),
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
                                    SelectType(context, 0, 'ร้านค้าทั่วไป'),
                                    SelectType(context, 1, 'ร้านอาหาร'),
                                    SelectType(context, 2, 'โฮสเทล'),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                    //

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('เลขประจำตัวผู้เสียภาษี'),
                          Container(
                            width: 200,
                            height: 40,
                            child: TextField(
                              controller: tax_id,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('POS ID'),
                          Container(
                            width: 200,
                            height: 40,
                            child: TextField(
                              controller: pos_id,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('สาขา'),
                          Container(
                            width: 90,
                            height: 40,
                            child: TextField(
                              controller: branch,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                hintText: '',
                              ),
                            ),
                          ),
                          const Text('เลขประจำเครื่อง'),
                          Container(
                            width: 90,
                            height: 40,
                            child: TextField(
                              controller: m_id,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('เวลาเปิดร้าน'),
                          Container(
                            width: 90,
                            height: 40,
                            child: TextField(
                              controller: time_open,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                hintText: '',
                              ),
                            ),
                          ),
                          const Text('เวลาปิดร้าน'),
                          Container(
                            width: 90,
                            height: 40,
                            child: TextField(
                              controller: time_close,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
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
                        const Text('ภาษีมูลค่าเพิ่ม'),
                        Container(
                          width: 100,
                          height: 40,
                          child: TextField(
                            controller: tax_val,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              hintText: '',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text('แยก'),
                              ),
                              //Switch Start
                              FlutterSwitch(
                                height: 20.0,
                                width: 40.0,
                                padding: 4.0,
                                toggleSize: 15.0,
                                borderRadius: 10.0,
                                activeColor: Colors.red,
                                value: tax,
                                onToggle: (value) {
                                  setState(() {
                                    tax = value;
                                  });
                                },
                              ),
                              //Switch Stop
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text('รวม'),
                              )
                            ],
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
                        const Text('ค่าบริการ'),
                        Row(
                          children: [
                            const Text('ใช้งานทุกบิล'),
                            //Switch Start
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: FlutterSwitch(
                                height: 20.0,
                                width: 40.0,
                                padding: 4.0,
                                toggleSize: 15.0,
                                borderRadius: 10.0,
                                activeColor: Colors.red,
                                value: bill,
                                onToggle: (value) {
                                  setState(() {
                                    bill = value;
                                  });
                                },
                              ),
                            ),
                            //Switch Stop
                          ],
                        ),
                        Container(
                          width: 110,
                          height: 40,
                          child: TextField(
                            controller: service_chage,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
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
                        const Text('การปัดเศษ'),
                        TextButton(
                            onPressed: () {
                              //
                              showCupertinoModalBottomSheet(
                                expand: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => const RoundSetting(),
                              );
                              //
                              print('show');
                              //
                            },
                            child: Row(
                              children: [
                                Text(
                                  'ไม่ปัดเศษ',
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                Icon(Icons.keyboard_arrow_right_outlined,
                                    color: Colors.grey[800])
                              ],
                            ))
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ),
            //Card 2 Stop

            //Card 3 Start
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
                        const Text('ที่อยู่บรรทัดที่ 1'),
                        Container(
                          width: 200,
                          height: 40,
                          child: TextField(
                            controller: adress1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
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
                        const Text('ที่อยู่บรรทัดที่ 2'),
                        Container(
                          width: 200,
                          height: 40,
                          child: TextField(
                            controller: adress2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
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
                        const Text('เบอร์โทรศัพท์'),
                        Container(
                          width: 200,
                          height: 40,
                          child: TextField(
                            controller: tel,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
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
            //Card 3 Stop
          ],
        ),
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
            style: const TextStyle(fontSize: 13),
          )),
        ),
      ),
    );
  }

  getData(Store provider) async {
    if (!check) await UserStore.getStore(provider: provider);
    setState(() {
      data[0] = provider.userData![0];
      print("userData ${provider.userData}");
      print("emial: ${provider.email}");
    });
    try {
      setState(() {
        print('เริ่ม...');
        List adress = data[0]['adress1_2'].toString().split(",");
        name = TextEditingController(text: data[0]['name_store']);
        tax_id = TextEditingController(text: data[0]['tax_id']);
        pos_id = TextEditingController(text: data[0]['pos_id']);
        branch = TextEditingController(text: data[0]['branch']);
        m_id = TextEditingController(text: data[0]['m_id']);
        time_open = TextEditingController(text: data[0]['time_open']);
        time_close = TextEditingController(text: data[0]['time_close']);
        tax_val = TextEditingController(text: data[0]['tax_val']);
        service_chage = TextEditingController(text: data[0]['service_chage']);
        is_doble = int.parse(data[0]['is_doble']);
        adress1 = TextEditingController(text: adress[0]);
        adress2 = TextEditingController(text: adress[1]);
        tel = TextEditingController(text: data[0]['tel_promt']);
        // name.value = TextEditingValue(text: "ANY TEXT");
        check = false;
        print('อัปเดทข้อมูลแล้ว➕');
      });
    } catch (e) {
      print("ไม่สามารถดึงข้อมูลจากUserStoreได้เพราะ: $e");
    }
  }
}
