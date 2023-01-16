import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmpos/provider/store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mmpos/API/service_api.dart';
import 'package:http/http.dart' as http;

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key, this.getIn});
  final getIn;
  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerCate = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController items_barcode = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController addTypeContoller = TextEditingController();
  int profit = 0;
  bool cateAdd = false;
  String? items;
  String? category;
  String? type;
  String? item;
  String? sizes;
  String? imageAddress;
  String? imageName;
  String is_use = "1";
  String is_show = "1";
  PlatformFile? image;
  XFile? imageWeb;
  String i = '';
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  var colorsPicked = Color(0xfff44336);
  var test = 2;
  XFile? showImage;
  List checkL = [
    {"check": false, "label": "สินค้ามีภาษี", "checkIn": 0},
    {"check": false, "label": "สินค้า-นิยท", "checkIn": 0},
    {"check": false, "label": "ค่าบริการ", "checkIn": 0},
    {"check": false, "label": "แสดงบนหน้าขาย", "checkIn": 0},
    {"check": false, "label": "ราคาด่วน", "checkIn": 0},
  ];
  List typeL = [
    "สินค้าทั่วไป",
    "สินค้าประกอบ(BOM)",
    "สินค้ามี Serial",
    "สินค้าบริการ (สินค้าไม่มีสต๊อก)",
  ];
  List typProduct = [
    "ชิ้น",
    "อัน",
    "จาน",
    "แก้ว",
  ];
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  List getCate = [];
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Store>();
    if (widget.getIn != null) setDataEdit();
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
                      Icons.close,
                      color: Colors.red,
                      size: 20,
                    ),
                  ],
                ))
          ],
        ),
        //
        title: Text(
          'สร้างสินค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'บันทึก',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
        //
      ),
      //Appbar Stop

      //
      body: Column(
        children: [
          //
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  color: Colors.red,
                )
              ],
            ),
          ),
          //
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
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
                      hintText: 'ชื่อสินค้า',
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 200,
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
                        hintText: 'ราคา',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 200,
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
                        hintText: 'รหัสสินค้า',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.barcode_viewfinder,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              //
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      isExpanded: true,
                      items: <String>[
                        '1 km',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('data'),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                //
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      isExpanded: true,
                      items: <String>[
                        'กระบอก',
                        'กระปุก',
                        'กระป๋อง',
                        'กระสอบ',
                        'กระเช้า',
                        'กล่อง',
                        'ก้อน',
                        'ชิ้น',
                        'ซอง',
                        'ด้าม',
                        'ถุง',
                        'ปอนด์',
                        'ฟอง',
                        'ลัง',
                        'หลอด',
                        'แกลลอน',
                        'แท่ง',
                        'เเพ็ค',
                        'ใบ',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        'ชิ้น',
                        style: TextStyle(color: Colors.black),
                      ),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              //
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      isExpanded: true,
                      items: <String>[
                        'สินค้าทั่วไป',
                        'สินค้าประกอบ(BOM)',
                        'สินค้ามี Serial',
                        'สินค้าบริการ (สินค้าไม่มีสต๊อก)',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('สินค้าทั่วไป',
                          style: TextStyle(color: Colors.black)),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                //
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      isExpanded: true,
                      items: <String>[
                        'สินค้าทั่วไป',
                        'สินค้าประกอบ(BOM)',
                        'สินค้ามี Serial',
                        'สินค้าบริการ (สินค้าไม่มีสต๊อก)',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('', style: TextStyle(color: Colors.black)),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ],
      ),
      //
    );
  }

  Row checkList(int i) {
    return Row(
      children: [
        Checkbox(
          value: checkL[i]['check'],
          onChanged: (value) {
            if (checkL[i]['checkIn'] == 0) {
              setState(() {
                checkL[i]['checkIn'] = 1;
                checkL[i]['check'] = true;
              });
            } else {
              setState(() {
                checkL[i]['checkIn'] = 0;
                checkL[i]['check'] = false;
              });
            }
          },
        ),
        Text(checkL[i]['label'])
      ],
    );
  }

  DropdownButton<Object> DropDownMet(Store provider, int val, String hint) {
    return DropdownButton(
      elevation: 10,
      value: val == 1
          ? item
          : val == 2
              ? category
              : val == 3
                  ? type
                  : sizes,
      hint: Text(hint),
      items: val == 1
          ? [...typProduct, "➕"]
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList()
          : val == 2
              ? provider.cate
                  .map((e) => DropdownMenuItem(
                      value: e['name'], child: Text(e['name'])))
                  .toList()
              : typeL
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
      onChanged: (value) => setState(() {
        val == 1
            // ignore: unnecessary_statements
            ? {
                if (value.toString() == "➕")
                  {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('เพิ่ม ชื่อเรียกสินค้า'),
                                TextField(),
                                OutlinedButton(
                                    onPressed: () =>
                                        typProduct.add(addTypeContoller.text),
                                    child: Text('เพิ่ม'))
                              ],
                            )),
                      ),
                    )
                  }
                else
                  {
                    item = value.toString(),
                  }
              }
            : val == 2
                ? category = value.toString()
                : val == 3
                    ? type = value.toString()
                    : sizes = value.toString();
        print(value.toString());
        print(item);
      }),
    );
  }

  Future<String> saveImageWeb(XFile fileImage) async {
    final appStorrage = await getApplicationDocumentsDirectory();
    final localImage = File('${appStorrage.path}/${fileImage.name}');
    print(localImage.path);
    File(fileImage.path).copy(localImage.path);
    setState(() {
      imageAddress = localImage.path;
    });
    return localImage.path;
  }

  Future<void> uploadImage() async {
    try {
      List<int> imageBytes = File(image!.path.toString()).readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      // print('$imageName');
      imageName = "${name.text}.${image!.extension}";
      var response = await http.post(
          Uri.parse('http://$config/mmposAPI/crud_mmpos.php'),
          body: {'image': baseimage, 'name': imageName});
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print("$e");
    }
  }

  clearData() {
    controllerName.clear();
    controllerPrice.clear();
    setState(() {
      imageAddress = '';
      imageName = '';
      items = null;
    });
  }

  getUpdate(Store provider) async {
    var request = await http
        .post(Uri.parse('http://$config/mmposAPI/items_crud.php'), body: {
      "action": "GET_ALL",
      "email": FirebaseAuth.instance.currentUser!.email
    });
    var res = jsonDecode(request.body);
    setState(() {
      provider.getItem(res);
    });
  }

  setDataEdit() {
    name = TextEditingController(text: widget.getIn['name']);
    price = TextEditingController(text: widget.getIn['price']);
    items_barcode = TextEditingController(text: widget.getIn['items_barcode']);
    weight = TextEditingController(text: widget.getIn['weight']);
    cost = TextEditingController(text: widget.getIn['cost']);
    quantity = TextEditingController(text: widget.getIn['quantity']);
    category = widget.getIn['category'];
    type = widget.getIn['type'];
    is_use = widget.getIn['is_use'];
    is_show = widget.getIn['is_show'];
    for (int i = 0; i < checkL.length; i++) {
      if (widget.getIn['check_list'][i] == "1") checkL[i]['check'] = true;
      // checkL[i]['check'] = true;
      // print(widget.getIn['check_list']);
    }
  }
}
