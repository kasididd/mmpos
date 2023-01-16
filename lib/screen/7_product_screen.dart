import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmpos/API/service_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../provider/store.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, this.getIn});
  final getIn;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  var colorsPicked = const Color(0xfff44336);
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
    return SafeArea(
      child: Scaffold(
          //APPBAR START
          appBar: AppBar(
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
              'เพิ่มกลุ่มสินค้า',
              style: TextStyle(color: Colors.black54, fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (name.text.length > 0 &&
                      price.text.length > 0 &&
                      items_barcode.text.length > 0 &&
                      category != null &&
                      type != null &&
                      weight.text.length > 0 &&
                      cost.text.length > 0 &&
                      quantity.text.length > 0) {
                    print('saving');

                    String nameAd = image != null
                        ? "http://$config/mmposAPI/image/${name.text}.${image!.extension}"
                        : "${colorsPicked.red},${colorsPicked.green},${colorsPicked.blue}";

                    if (name != null) {
                      await uploadImage();
                      String check_list = checkL
                          .map((e) => e['checkIn'])
                          .toList()
                          .join()
                          .toString();
                      widget.getIn == null
                          ? await DataBase.insertU(
                              provider: provider,
                              name: name.text,
                              image: nameAd,
                              price: price.text,
                              items_barcode: items_barcode.text,
                              category: category!,
                              type: type!,
                              weight: weight.text,
                              check_list: check_list,
                              is_use: is_use,
                              is_show: is_show,
                              cost: cost.text,
                              quantity: quantity.text)
                          : await DataBase.update(
                              u_id: widget.getIn['u_id'],
                              name: name.text,
                              image: nameAd,
                              price: price.text,
                              items_barcode: items_barcode.text,
                              category: category!,
                              type: type!,
                              weight: weight.text,
                              check_list: check_list,
                              is_use: is_use,
                              is_show: is_show,
                              cost: cost.text,
                              quantity: quantity.text);
                      // clearData();
                      print(check_list);
                      print('saved');
                      await getUpdate(provider);
                      Navigator.of(context).pop();
                    }
                  } else {
                    print('ไม่สามารถแอดได้เนื่องจากไม่มีข้อมูล');
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text('กรุณาใส่ข้อมูลให้ครบ'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'บันทึก',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
          //APPBAR STOP

          //BODY START
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // line1
                    Utility.phonCheck(context)
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () async => await pickImage(context),
                                child: imageContainer(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // line2
                              line2(context, provider),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: GestureDetector(
                                  onTap: () async => await pickImage(context),
                                  child: imageContainer(),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // line2
                              Expanded(child: line2(context, provider)),
                            ],
                          ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              for (int i = 0; i < 3; i++) checkList(i),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              for (int i = 3; i < checkL.length; i++)
                                checkList(i),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5.4,
                          height: 40,
                          child: TextField(
                            controller: quantity,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: 'จำนวน'),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.4,
                          height: 40,
                          child: TextField(
                            onChanged: (value) => setState(() {
                              if (price.text.length != 0 &&
                                  cost.text.length != 0) {
                                profit = int.parse(price.text) -
                                    int.parse(cost.text);
                              } else {
                                profit = 0;
                              }
                            }),
                            controller: cost,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                hintText: 'ต้นทุน'),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 3.4,
                            child: Column(
                              children: [
                                const Text('กำไรที่ได้/ชิ้น'),
                                Text(
                                  "$profit",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Column line2(BuildContext context, Store provider) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    hintText: 'ชื่อสินค้า',
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        onChanged: (value) => setState(() {
                          if (price.text.length != 0 &&
                              cost.text.length != 0 &&
                              int.parse(cost.text).runtimeType == int) {
                            profit =
                                int.parse(price.text) - int.parse(cost.text);
                          } else {
                            profit = 0;
                          }
                        }),
                        controller: price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            hintText: 'ราคา'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: items_barcode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            hintText: 'รหัส'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropDownMet(provider, 2, 'Uncatecory'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: weight,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            hintText: 'น้ำหนัก'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownMet(provider, 3, 'สินค้าทั้วไป'),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownMet(provider, 1, 'ชิ้น'),
              ),
            ),
            cateAdd
                ? Row(
                    children: [
                      SizedBox(
                          width: 70,
                          height: 30,
                          child: TextField(
                            controller: controllerCate,
                          )),
                    ],
                  )
                : const Text(''),
          ],
        ),
      ],
    );
  }

  Container imageContainer() {
    return Container(
      color: widget.getIn != null
          ? (double.tryParse(widget.getIn['image'][0]) == null
              ? colorsPicked
              : myDecoder.readColor(widget.getIn['image']))
          : colorsPicked,
      width: 100,
      height: 100,
      child: image != null || widget.getIn != null
          ? Center(
              child: Stack(children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: image == null
                      ? (double.tryParse(widget.getIn['image']) != null
                          ? Image.network(
                              widget.getIn['image'],
                              fit: BoxFit.cover,
                            )
                          : const Text(''))
                      : Image.file(
                          File(image!.path.toString()),
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                    bottom: 20,
                    right: 4,
                    child: Container(
                      color: const Color.fromARGB(158, 32, 142, 232),
                      child: const Text(
                        'แตะเพื่อแก้ไข',
                        style: TextStyle(fontSize: 16),
                      ),
                    ))
              ]),
            )
          : const Center(child: Text('กดเพื่อใส่รูป')),
    );
  }

  pickImage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * .5,
            height: MediaQuery.of(context).size.height * .5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () async {
                        print('takePic');
                        if (kIsWeb) {
                          final newimage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (newimage != null) {
                            final file = newimage;
                            setState(() {
                              imageWeb = file;
                              showImage = file;
                            });
                          } else {
                            return;
                          }
                        }
                        if (!kIsWeb) {
                          final newimage = await FilePicker.platform
                              .pickFiles(type: FileType.image);
                          if (newimage != null) {
                            final file = newimage.files.first;
                            setState(() {
                              image = file;
                            });
                          } else {
                            return;
                          }
                        }
                      },
                      child: SizedBox(
                        width: 200,
                        child: Card(
                          elevation: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.image,
                                color: Colors.grey,
                              ),
                              const Text(
                                'เพิ่มรูปภาพ',
                                style:
                                    TextStyle(fontSize: 24, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 400,
                    child: BlockPicker(
                      pickerColor: Colors.red,
                      onColorChanged: (color) {
                        setState(() {
                          colorsPicked = color;
                          if (widget.getIn != null) {
                            widget.getIn['image'] =
                                "${colorsPicked.red},${colorsPicked.green},${colorsPicked.blue}";
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      layoutBuilder: (context, colors, child) {
                        return GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 100,
                            mainAxisSpacing: 10,
                          ),
                          children: [for (Color color in colors) child(color)],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
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
                                const Text('เพิ่ม ชื่อเรียกสินค้า'),
                                const TextField(),
                                OutlinedButton(
                                    onPressed: () =>
                                        typProduct.add(addTypeContoller.text),
                                    child: const Text('เพิ่ม'))
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
    var request = await http.post(
        Uri.parse('http://$config/mmposAPI/items_crud.php'),
        body: {"action": "GET_ALL", "email": provider.email['email']});
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
