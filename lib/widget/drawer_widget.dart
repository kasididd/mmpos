import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmpos/layout/phone.dart';
import 'package:mmpos/layout/tablet.dart';
import 'package:mmpos/screen/1-bill.dart';
import 'package:mmpos/screen/2-dashboard.dart';
import 'package:mmpos/screen/3-stock.dart';
import 'package:mmpos/screen/4-customer.dart';
import 'package:mmpos/screen/5-all_stock.dart';
import 'package:mmpos/screen/6-dollar.dart';
import 'package:mmpos/setting/layout/setting_tablet.dart';
import 'package:mmpos/setting/layout/settint_phone.dart';
import '../main.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    setState(() {});

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItem(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Column(
        children: [
          Card(
              //
              elevation: 0,
              //
              child: Column(
                children: [
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      //
                      mainAxisAlignment: MainAxisAlignment.center,
                      //
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.25), // border color
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      //
                      mainAxisAlignment: MainAxisAlignment.center,
                      //
                      children: [
                        Text(
                          'MMPOS',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      //
                      mainAxisAlignment: MainAxisAlignment.center,
                      //
                      children: [
                        Text(
                          'test@gmail.com',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  //
                  Divider(),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      //
                      mainAxisAlignment: MainAxisAlignment.center,
                      //
                      children: [
                        Text(
                          'Admin',
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      );

  Widget buildMenuItem(BuildContext context) => Column(
        children: [
          //
          Card(
            //
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/icons/shop.png'),
                  ),
                  title: const Text('หน้าร้าน'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MediaQuery.of(context).size.width >
                              MediaQuery.of(context).size.height
                          ? TabletTable()
                          : PhoneTable(),
                    ));
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/icons/bill.png'),
                  ),
                  title: const Text('การจัดการบิล'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BillScreen()));
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/icons/dashboard.png'),
                  ),
                  title: const Text('รายงาน'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DashBoard(),
                    ));
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/icons/stock.png'),
                  ),
                  title: const Text('คลังสินค้า'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StockPage(),
                    ));
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/icons/account.png'),
                  ),
                  title: const Text('ลูกค้า'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Customer(),
                    ));
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/icons/all_stock.png'),
                  ),
                  title: const Text('สินค้าทั้งหมด'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllStock(),
                    ));
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/icons/coins.png'),
                  ),
                  title: const Text('จัดการเงินสด'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DollarScreen(),
                    ));
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/icons/setting.png'),
                  ),
                  title: const Text('การตั้งค่า'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MediaQuery.of(context).size.width >
                              MediaQuery.of(context).size.height
                          ? TabletSettingLayout()
                          : PhoneSettingLayout(),
                    ));
                  },
                ),
              ],
            ),
            //
          ),
        ],
      );
}
