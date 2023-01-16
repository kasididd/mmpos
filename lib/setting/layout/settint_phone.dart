import 'package:flutter/material.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/setting/backend/1-shop.dart';
import 'package:mmpos/setting/backend/11-member.dart';
import 'package:mmpos/setting/backend/12-contact.dart';
import 'package:mmpos/setting/backend/13-account.dart';
import 'package:mmpos/setting/backend/2-language.dart';
import 'package:mmpos/setting/backend/3-bill.dart';
import 'package:mmpos/setting/backend/4-payment.dart';
import 'package:mmpos/setting/backend/5-setpayment.dart';
import 'package:mmpos/setting/backend/6-print.dart';
import 'package:mmpos/setting/backend/7-display.dart';
import 'package:mmpos/setting/backend/8-user.dart';
import 'package:mmpos/setting/backend/9-backup.dart';
import 'package:mmpos/widget/drawer_widget.dart';
import 'package:provider/provider.dart';

class PhoneSettingLayout extends StatefulWidget {
  const PhoneSettingLayout({super.key});

  @override
  State<PhoneSettingLayout> createState() => _PhoneSettingLayoutState();
}

class _PhoneSettingLayoutState extends State<PhoneSettingLayout> {
  TextEditingController val = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Store provider = context.watch<Store>();
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade200,
      //
      drawer: DrawerWidget(
        provider: provider,
      ),
      //Appbar Start
      appBar: size.width > size.height
          ? null
          : AppBar(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShopSetting(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LanguageSetting(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BillSetting(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentSetting(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SetPayment(),
                      ));
                    },
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
                      child: Image.asset('assets/icons/printer.png'),
                    ),
                    title: Text(
                      'ตั้งค่าเครื่องพิมพ์และเครื่องอ่านบาร์โค้ด',
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrintSetting(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DisplaySetting(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserSetting(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Backup(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PhoneSettingLayout(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MemberSetting(),
                      ));
                    },
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
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Contact(),
                      ));
                    },
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
                      child: Image.asset('assets/icons/account_setting.png'),
                    ),
                    title: Text(
                      'บัญชีร้านค้า',
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AccountSetting(),
                      ));
                    },
                  ),
                ],
              ),
            ),
            //Card 5 Stop
          ],
        ),
      ),
    );
  }
}
