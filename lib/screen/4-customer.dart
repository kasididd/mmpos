import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:mmpos/API/service_api.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/widget/drawer_widget.dart';
import 'package:mmpos/widget/g_function.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  TextEditingController search = TextEditingController();
  getCustomer(Store provider) async {
    await CustomerAPI().select(provider: provider);
    await CateCustomer().select(provider: provider);
    check = false;
  }

  editCustomer({required dynamic update}) async {
    final data = await showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCustomer(update: update),
    );
    setState(() {
      if (data != null) {
        if (data) check = data;
      }
    });
  }

  bool check = true;
  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();
    if (check) getCustomer(provider);
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
                  icon: Icon(
                    Icons.menu,
                    color: Colors.red,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer()),
        ),
        //
        title: Text(
          'ลูกค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
        actions: [
          TextButton(
              onPressed: () async {
                //
                final data = await showCupertinoModalBottomSheet(
                  expand: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddCustomer(),
                );
                setState(() {
                  if (data != null) {
                    if (data) check = data;
                  } else {
                    print('object');
                  }
                });
              },
              child: Text(
                'เพิ่มลูกค้า',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      body: check
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: searcher(
                      suggest: provider.customer.map((e) => e['tel']).toList(),
                      text: "ค้นหาด้วยเบอร์..."),
                ),
                Expanded(
                  child: provider.customer.isEmpty
                      ? Center(child: Text('ไม่มีรายชื่อลูกค้า'))
                      : ListView(children: [
                          for (int i = 0; i < provider.customer.length; i++)
                            Slidable(
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) async =>
                                          editCustomer(
                                              update: provider.customer[i]),
                                      icon: Icons.edit,
                                      backgroundColor: Colors.amber,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) async => {
                                        await CustomerAPI().delete(
                                            u_id: provider.customer[i]['u_id'],
                                            email: provider.email['email']),
                                        setState(
                                          () => check = true,
                                        )
                                      },
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red,
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: ClipOval(
                                        child: Container(
                                      color: Colors.amber,
                                      child: Center(
                                          child: Text(provider.customer[0]
                                              ['lname'][0])),
                                    )),
                                  ),
                                  title: Text(
                                      "${provider.customer[i]['fname']} ${provider.customer[i]['lname']}"),
                                  trailing: Text(provider.customer[i]['tel']),
                                ),
                              ),
                            )
                        ]),
                ),
              ],
            ),
      //Appbar Stop
    );
  }

  SearchField searcher({required String text, required List suggest}) {
    return SearchField(
      controller: search,
      searchInputDecoration: InputDecoration(
        border: InputBorder.none,
        icon: const Icon(Icons.search),
        hintText: text,
      ),
      itemHeight: 50,
      maxSuggestionsInViewPort: 7,
      suggestionsDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      suggestions: suggest
          .map(
            (element) => SearchFieldListItem(element.toString(),
                item: element,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(element.toString()),
                )),
          )
          .toList(),
    );
  }
}

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key, this.update});
  final dynamic update;
  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  int sex = 3;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController c_group = TextEditingController();
  TextEditingController bday = TextEditingController();
  List test = [];
  getCate(Store provider) {
    setState(() {
      test = provider.cateGr!.map((e) => e['name']).toList();
    });
  }

  setUpdate() {
    fname = TextEditingController(text: widget.update['fname']);
    lname = TextEditingController(text: widget.update['lname']);
    tel = TextEditingController(text: widget.update['tel']);
    c_group = TextEditingController(text: widget.update['c_group']);
    bday = TextEditingController(text: widget.update['bday']);
    sex = widget.update['sex'] == "ชาย"
        ? 1
        : widget.update['หญิง']
            ? 2
            : 3;
    setState(() {
      check = false;
    });
  }

  bool check = true;
  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();
    String email = provider.email['email'];
    getCate(provider);
    if (check) setUpdate();
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
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })),
        //
        title: Text(
          'เพิ่มข้อมูลลูกค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
      ),
      //Appbar Stop

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
                  child: Row(
                    children: [
                      Text('ชื่อ ลูกค้า'),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Container(
                    height: 35,
                    child: TextField(
                      controller: fname,
                      keyboardType: TextInputType.name,
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
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    children: [
                      Text('นามสกุล ลูกค้า'),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Container(
                    height: 35,
                    child: TextField(
                      controller: lname,
                      keyboardType: TextInputType.name,
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
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    children: [
                      Text('เพศ'),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                //
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: sex,
                                  onChanged: (value) {
                                    setState(() {
                                      sex = value!;
                                    });
                                  }),
                              Text('ชาย')
                            ],
                          ),
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: sex,
                                  onChanged: (value) {
                                    setState(() {
                                      sex = value!;
                                    });
                                  }),
                              Text('หญิง')
                            ],
                          ),
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Radio(
                                  value: 3,
                                  groupValue: sex,
                                  onChanged: (value) {
                                    setState(() {
                                      sex = value!;
                                    });
                                  }),
                              Text('ไม่ระบุ')
                            ],
                          ),
                        ),
                      ],
                    )),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    children: [
                      Text('เบอร์โทรศัพท์'),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Container(
                    height: 65,
                    child: TextField(
                      maxLength: 10,
                      controller: tel,
                      keyboardType: TextInputType.number,
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
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    children: [
                      Text('วัน-เดือน-ปี เกิด'),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Container(
                    height: 35,
                    child: TextField(
                      controller: bday,
                      keyboardType: TextInputType.datetime,
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
                ),
                //
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    children: [
                      Text('กลุ่มลูกค้า'),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  child: Container(
                      height: 65,
                      child: SearchField(
                        controller: c_group,
                        searchInputDecoration: InputDecoration(
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
                        itemHeight: 50,
                        maxSuggestionsInViewPort: 3,
                        suggestionsDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suggestions: test
                            .map(
                              (e) => SearchFieldListItem(e,
                                  item: e.toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(e),
                                  )),
                            )
                            .toList(),
                      )),
                ),
                //
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Container(
                    //
                    width: double.infinity,
                    //
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () async {
                        if (widget.update != null) {
                          await CustomerAPI().updateCustomer(
                              fname: fname.text,
                              lname: lname.text,
                              tel: tel.text,
                              sex: sex == 1
                                  ? "ชาย"
                                  : sex == 2
                                      ? "หญิง"
                                      : "ไม่ระบุ",
                              c_group: c_group.text,
                              email: email,
                              bday: bday.text,
                              u_id: widget.update['u_id']);
                          Navigator.pop(context, true);
                        } else {
                          if (c_group.text.isNotEmpty &&
                              fname.text.isNotEmpty &&
                              lname.text.isNotEmpty &&
                              tel.text.isNotEmpty &&
                              c_group.text.isNotEmpty &&
                              bday.text.isNotEmpty) {
                            await CustomerAPI().insertU(
                                fname: fname.text.trim(),
                                lname: lname.text.trim(),
                                tel: tel.text.trim(),
                                sex: sex == 1
                                    ? "ชาย"
                                    : sex == 2
                                        ? "หญิง"
                                        : "ไม่ระบุ",
                                c_group: c_group.text.trim(),
                                email: email,
                                bday: bday.text.trim());
                            // gr.where((element) => element['name'])
                            final gr = provider.cateGr!;
                            final list = gr
                                .where(
                                  (element) => element['name'] == c_group.text,
                                )
                                .toList();
                            if (list.isEmpty) {
                              await CateCustomer().insertU(
                                  name: c_group.text.trim(),
                                  provider: provider);
                            }
                            Navigator.pop(context, true);
                          }
                        }
                      },
                      child: const Text('บันทึก'),
                    ),
                  ),
                ),
              ],
            ),
          )
          //
        ],
      ),
    );
  }
}
