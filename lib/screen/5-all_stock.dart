import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mmpos/API/service_api.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/screen/4-customer.dart';
import 'package:mmpos/screen/7_product_screen.dart';
import 'package:mmpos/src/add-product.dart';
import 'package:mmpos/widget/drawer_widget.dart';
import 'package:mmpos/widget/g_function.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class AllStock extends StatefulWidget {
  const AllStock({super.key});

  @override
  State<AllStock> createState() => _AllStockState();
}

class _AllStockState extends State<AllStock> {
  TextEditingController search = TextEditingController();
  int curIndex = 0;
  List Pages = [const StockInshope(), const Center()];
  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();
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
        title: const Text(
          'จัดการสินค้า',
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
                  builder: (context) => const AddStock(),
                );
                //
              },
              child: const Icon(
                Icons.add,
                color: Colors.red,
              ))
        ],
      ),
      //Appbar Stop
      body: Pages[curIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_shipping,
              ),
              label: "สินค้าในร้าน"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code,
              ),
              label: "พิมพ์บาร์โค้ด"),
        ],
        currentIndex: curIndex,
        onTap: (value) => setState(() {
          curIndex = value;
        }),
      ),
    );
  }
}

class AddStock extends StatefulWidget {
  const AddStock({super.key});

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  bool silbar = false;
  Color colorsPicked = const Color(0xfff44336);

  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade200,
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
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })),
        //
        title: const Text(
          'เพิ่มกลุ่มสินค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'บันทึก',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      //Appbar Stop

      //
      body: Column(
        children: [
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
                  child: SizedBox(
                    height: 36,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: const Text('ชื่อสินค้า')),
                        Expanded(
                          flex: Utility.phonCheck(context) ? 4 : 2,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
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
                        )
                      ],
                    ),
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => print(
                              "${provider.colorPick.red},${provider.colorPick.green},${provider.colorPick.blue}"),
                          child: const Text('สีพื้นหลัง')),
                      InkWell(
                        onTap: () async {
                          await ColorPick().pickColor(
                              context,
                              MediaQuery.of(context).size,
                              provider.colorPick,
                              setState,
                              provider);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          color: provider.colorPick == null
                              ? Colors.red
                              : provider.colorPick,
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
                      const Text('ใช้งาน'),
                      //Switch Start
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        borderRadius: 10.0,
                        activeColor: Colors.red,
                        value: silbar,
                        onToggle: (value) {
                          setState(() {
                            silbar = value;
                          });
                        },
                      ),
                      //Switch Stop
                    ],
                  ),
                ),
              ],
            ),
          )
          //
        ],
      ),
      //
    );
  }
}

class StockInshope extends StatefulWidget {
  const StockInshope({super.key});

  @override
  State<StockInshope> createState() => _StockInshopeState();
}

class _StockInshopeState extends State<StockInshope> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Utility().searcher(
                  text: "ค้นหาสินค้าทั้งหมด...",
                  suggest: provider.item!.map((e) => e['name']).toList(),
                  search: search),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            'กลุ่มสินค้าทั้งหมด',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            for (int i = 0; i < 3; i++)
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailStock(),
                    )),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top:
                            BorderSide(width: 1.0, color: Colors.grey.shade200),
                        bottom:
                            BorderSide(width: 1.0, color: Colors.grey.shade200),
                      )),
                  child: ListTile(
                    title: Row(
                      children: [
                        ClipOval(
                            child: Container(
                          width: 15,
                          height: 15,
                          color: Colors.green,
                        )),
                        const Text('  data')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              )
          ],
        ))
      ],
    );
  }
}

class DetailStock extends StatefulWidget {
  const DetailStock({super.key});

  @override
  State<DetailStock> createState() => _DetailStockState();
}

class _DetailStockState extends State<DetailStock> {
  int switcher = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.green[700],
                    ),
                    Text(
                      'ย้อนกลับ',
                      style: TextStyle(color: Colors.green[700], fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              "สินค้านิยม(2)",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => print('edit'),
                  child: Text("แก้ไข",
                      style: TextStyle(color: Colors.green[700], fontSize: 16)),
                ),
                TextButton(
                  onPressed: () => showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => ProductScreen(),
                  ),
                  child: Text("เพิ่มสินค้า",
                      style: TextStyle(color: Colors.green[700], fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'เรียงโดย',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => setState(() {
                              switcher = 1;
                            }),
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                    color: switcher == 0
                                        ? Colors.grey.shade300
                                        : Colors.white,
                                    border: Border.all(
                                        width: 1,
                                        color: switcher == 0
                                            ? Colors.transparent
                                            : Colors.green.shade400)),
                                child: Text(
                                  "หน้าขาย",
                                  style: TextStyle(
                                    color: switcher == 0
                                        ? Colors.grey.shade700
                                        : Colors.green.shade400,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => setState(() {
                              switcher = 0;
                              print(switcher);
                            }),
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                    color: switcher == 1
                                        ? Colors.grey.shade300
                                        : Colors.white,
                                    border: Border.all(
                                        width: 1,
                                        color: switcher == 1
                                            ? Colors.transparent
                                            : Colors.green.shade400)),
                                child: Text(
                                  "ชื่อสินค้า",
                                  style: TextStyle(
                                    color: switcher == 1
                                        ? Colors.grey.shade700
                                        : Colors.green.shade400,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
