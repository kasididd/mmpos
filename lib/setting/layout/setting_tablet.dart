import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/widget/drawer_widget.dart';

class TabletSettingLayout extends StatefulWidget {
  const TabletSettingLayout({super.key});

  @override
  State<TabletSettingLayout> createState() => _TabletSettingLayoutState();
}

class _TabletSettingLayoutState extends State<TabletSettingLayout> {
  List listContainer = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.purple,
    ),
  ];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade200,
      //
      drawer: DrawerWidget(),
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
          'การตั้งค่า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
      ),
      //Appbar Stop
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    //Card 1 Start
                    Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/shop.png'),
                            ),
                            title: Text(
                              'ร้านค้า',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/language.png'),
                            ),
                            title: Text(
                              'ตั้งค่าภาษา',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/bill.png'),
                            ),
                            title: Text(
                              'ใบเสร็จรับเงิน',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/credit.png'),
                            ),
                            title: Text(
                              'การชำระเงิน',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/dollar.png'),
                            ),
                            title: Text(
                              'จัดการเงินสด',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
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
                        children: [
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/printer.jpg'),
                            ),
                            title: Text(
                              'ตั้งค่าเครื่องพิมพ์และเครื่องอ่านบาร์โค้ด',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/display.png'),
                            ),
                            title: Text(
                              'จอแสดงผลฝั่งลูกค้า',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/account.png'),
                            ),
                            title: Text(
                              'พนักงาน',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
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
                        children: [
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/cloud.png'),
                            ),
                            title: Text(
                              'สำรอง & กู้คืน ข้อมูล',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/connect.png'),
                            ),
                            title: Text(
                              'การเชื่อมต่อข้อมูล',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                        ],
                      ),
                    ),
                    //Card 3 Stop

                    //Card 4 Start
                    Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/star.png'),
                            ),
                            title: Text(
                              'ระบบสมาชิก',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/waring.png'),
                            ),
                            title: Text(
                              'แจ้งปัญหาการใช้งาน',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          //
                        ],
                      ),
                    ),
                    //Card 4 Stop

                    //Card 5 Start
                    Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          //
                          ListTile(
                            leading: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset(
                                  'assets/icons/account_setting.png'),
                            ),
                            title: Text(
                              'บัญชีร้านค้า',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Card 5 Stop
                    // TextButton(
                    //     onPressed: () => setState(() {
                    //           i = 2;
                    //         }),
                    //     child: Text("หน้า3")),
                  ],
                )),
            Expanded(flex: 5, child: listContainer[i]),
          ],
        ),
      ),
    );
  }
}
