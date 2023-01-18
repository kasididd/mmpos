import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmpos/API/service_api.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/widget/g_function.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  bool user = true;
  bool val = true;
  EmpApi emp = new EmpApi();
  bool check = true;
  getEmp(Store provider) async {
    print("get");
    // await Future.delayed(Duration(seconds: 2));
    var res = emp.select(email: provider.email['email'], provider: provider);
    check = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Store provider = context.watch<Store>();
    if (check) getEmp(provider);
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
                        builder: (context) =>
                            const addUser(isUpdate: false, data: null),
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

      body: provider.emp == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
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
                ),
                if (user)
                  Expanded(
                      child: ListView(
                    children: [
                      for (int i = 0; i < provider.emp!.length; i++)
                        Slidable(
                          endActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: (context) async => {
                                await EmpApi().delete(
                                    u_id: provider.emp![i]['u_id'],
                                    email: provider.email['email']),
                                await getEmp(provider)
                              },
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                            )
                          ]),
                          child: InkWell(
                            onTap: () => showCupertinoModalBottomSheet(
                              expand: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => addUser(
                                  isUpdate: true, data: provider.emp![i]),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                  leading: Container(
                                    width: 80,
                                    height: 100,
                                    child: Container(
                                        color: Colors.grey.shade400,
                                        child: provider.emp![i]['image'] == "0"
                                            ? Image.network(
                                                "http://$config/mmposAPI/image/defualImage.png")
                                            : Image.network(
                                                provider.emp![i]['image'],
                                                fit: BoxFit.fitHeight,
                                              )),
                                  ),
                                  title: Text(provider.emp![i]['e_name']),
                                  trailing: Icon(Icons.arrow_forward_ios)),
                            ),
                          ),
                        )
                    ],
                  ))
              ],
            ),

      //
    );
  }
}

//

class addUser extends StatefulWidget {
  const addUser({super.key, required this.isUpdate, required this.data});
  final bool isUpdate;
  final dynamic data;
  @override
  State<addUser> createState() => _addUserState();
}

class _addUserState extends State<addUser> {
  //
  TextEditingController e_name = TextEditingController();
  TextEditingController e_pass = TextEditingController();
  File? imageUser;
  PlatformFile? imageToUp;
  List? data;
  List setting2 = [
    "สร้างเอกสารรับเข้า",
    "แก้ไขเอกสารรับเข้า",
    "สร้างเอกสารจ่ายออก",
    "แก้ไขเอกสารจ่ายออก",
    "ปรับปรุงสต๊อก",
  ];
  List setting1 = [
    "จัดการสินค้า",
    "จัดการบิล",
    "ยกเลิกการขาย",
    "จัดการคลังสินค้า",
    "เรียกดูรายงาน",
    "ลูกค้า",
    "การตั้งค่า",
    "เปิดลิ้นชักเก็บเงิน",
    "พนักงาน",
    "แสดงกำไรที่ได้",
  ];
  String Vsetting1 = "0000000000";
  String Vsetting2 = "00000";
  List valSetting1 = List.generate(10, (index) => false);
  List valSetting2 = List.generate(5, (index) => false);
  //
  bool check = false;
  bool updateCheck = true;
  @override
  Widget build(BuildContext context) {
    if (widget.isUpdate) print("isUpdate");
    Store provider = context.watch<Store>();
    if (widget.data != null && updateCheck) {
      setState(() {
        e_name = TextEditingController(text: widget.data['e_name']);
        e_pass = TextEditingController(text: widget.data['e_pass']);
        for (int i = 0; i < 10; i++)
          valSetting1[i] = widget.data['setting1'][i] == "0" ? false : true;
        for (int i = 0; i < 5; i++)
          valSetting2[i] = widget.data['setting2'][i] == "0" ? false : true;
        updateCheck = false;
      });
    }
    getVal();
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
          widget.isUpdate ? "แก้ไขข้อมูลพนักงาน" : 'เพิ่มพนักงาน',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
        actions: [
          TextButton(
              onPressed: e_name.text.isEmpty || e_pass.text.isEmpty
                  ? () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('ใส่ข้อมูล ชื่อ และ รหัส'),
                        ),
                      )
                  : () async {
                      if (imageToUp != null)
                        await new ImageUpload().uploadImage(
                            name: e_name.text,
                            image: imageToUp!,
                            provider: provider);
                      widget.data == null
                          ? await new EmpApi().insertU(
                              e_name: e_name.text,
                              e_pass: e_pass.text,
                              setting1: Vsetting1,
                              setting2: Vsetting2,
                              image: imageToUp == null
                                  ? "0"
                                  : provider.imageAddress.toString(),
                              email: provider.email['email'])
                          : await new EmpApi().update(
                              u_id: widget.data['u_id'],
                              e_name: e_name.text,
                              e_pass: e_pass.text,
                              setting1: Vsetting1,
                              setting2: Vsetting2,
                              image: imageToUp == null
                                  ? widget.data['image']
                                  : provider.imageAddress.toString(),
                              email: provider.email['email']);

                      var res = await EmpApi().select(
                          email: provider.email['email'], provider: provider);

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
                            FilePickerResult? newimage = await FilePicker
                                .platform
                                .pickFiles(type: FileType.image);
                            if (newimage != null) {
                              final file = newimage;
                              setState(() {
                                imageToUp = file.files.first;
                                imageUser =
                                    File(file.files.first.path.toString());
                              });
                            } else {
                              return;
                            }
                          }
                        },
                        child: Container(
                          color: Colors.grey.shade200,
                          width: 150,
                          height: 150,
                          child: widget.data == null
                              ? imageUser != null
                                  ? Image.file(
                                      File(imageUser!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      CupertinoIcons.photo_on_rectangle,
                                      size: 30,
                                      color: Colors.grey,
                                    )
                              : widget.data['image'] != "0" && imageUser == null
                                  ? Image.network(widget.data['image'])
                                  : imageUser != null
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
                            controller: e_name,
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
                            keyboardType: TextInputType.number,
                            controller: e_pass,
                            obscureText: true,
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
                  for (int i = 0; i < setting1.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(setting1[i]),
                          //Switch Start
                          FlutterSwitch(
                            height: 20.0,
                            width: 40.0,
                            padding: 4.0,
                            toggleSize: 15.0,
                            borderRadius: 10.0,
                            activeColor: Colors.red,
                            value: valSetting1[i],
                            onToggle: (value) {
                              setState(() {
                                valSetting1[i] = value;
                              });
                            },
                          ),
                          //Switch Stop
                        ],
                      ),
                    ),
                  //

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
                  for (int i = 0; i < setting2.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(setting2[i]),
                          //Switch Start
                          FlutterSwitch(
                            height: 20.0,
                            width: 40.0,
                            padding: 4.0,
                            toggleSize: 15.0,
                            borderRadius: 10.0,
                            activeColor: Colors.red,
                            value: valSetting2[i],
                            onToggle: (value) {
                              setState(() {
                                valSetting2[i] = value;
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
          ],
        ),
      ),
    );
  }

  getData(Store provider) async {
    if (!check) await UserStore.getStore(provider: provider);
    setState(() {
      data![0] = provider.userData![0];
      print("userData ${provider.userData}");
      print("emial: ${provider.email}");
    });
    try {
      int i = 0;
      setState(() {
        print('เริ่ม...');
        List adress = data![0]['adress1_2'].toString().split(",");

        // name.value = TextEditingValue(text: "ANY TEXT");
        check = false;
        print('อัปเดทข้อมูลแล้ว➕');
      });
    } catch (e) {
      print("ไม่สามารถดึงข้อมูลจากUserStoreได้เพราะ: $e");
    }
  }

  getVal() {
    Vsetting1 = valSetting1
        .map(
          (e) => e == false ? 0 : 1,
        )
        .join()
        .toString();
    Vsetting2 = valSetting2
        .map(
          (e) => e == false ? 0 : 1,
        )
        .join()
        .toString();
  }
}

//
