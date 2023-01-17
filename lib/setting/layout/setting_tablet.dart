import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'settint_phone.dart';

class TabletSettingLayout extends StatefulWidget {
  const TabletSettingLayout({super.key});

  @override
  State<TabletSettingLayout> createState() => _TabletSettingLayoutState();
}

class _TabletSettingLayoutState extends State<TabletSettingLayout> {
  List listPage = [
    const ShopSetting(),
    const LanguageSetting(),
    const BillSetting(),
    const PaymentSetting(),
    const SetPayment(),
    const PrintSetting(),
    const DisplaySetting(),
    const UserSetting(),
    const Backup(),
    const PhoneSettingLayout(),
    const MemberSetting(),
    const Contact(),
    const AccountSetting(),
  ];
  int i = 0;
  int currenIndex = 0;
  List sideClick = [
    {
      "image": 'assets/icons/shop.png',
      "text": 'ร้านค้า',
    },
    {
      "image": 'assets/icons/language.png',
      "text": 'ตั้งค่าภาษา',
    },
    {
      "image": 'assets/icons/bill.png',
      "text": 'ใบเสร็จรับเงิน',
    },
    {
      "image": 'assets/icons/credit.png',
      "text": 'การชำระเงิน',
    },
    {
      "image": 'assets/icons/dollar.png',
      "text": 'จัดการเงินสด',
    },
    {
      "image": 'assets/icons/printer.png',
      "text": 'ตั้งค่าเครื่องพิมพ์และเครื่องอ่านบาร์โค้ด',
    },
    {
      "image": 'assets/icons/display.png',
      "text": 'จอแสดงผลฝั่งลูกค้า',
    },
    {
      "image": 'assets/icons/account.png',
      "text": 'พนักงาน',
    },
    {
      "image": 'assets/icons/cloud.png',
      "text": 'สำรอง & กู้คืน ข้อมูล',
    },
    {
      "image": 'assets/icons/connect.png',
      "text": 'การเชื่อมต่อข้อมูล',
    },
    {
      "image": 'assets/icons/star.png',
      "text": 'ระบบสมาชิก',
    },
    {
      "image": 'assets/icons/waring.png',
      "text": 'แจ้งปัญหาการใช้งาน',
    },
    {
      "image": 'assets/icons/account_setting.png',
      "text": 'บัญชีร้านค้า',
    },
  ];
  List listTitle = [
    "ร้านค้า",
    "ตั้งค่าภาษา",
    "ใบเสร็จรับเงิน",
    "การชำระเงิน",
    "จัดการเงินสด",
    "ตั้งค่าเครื่องพิมพ์และเครื่องอ่านบาร์โค้ด",
    "จอแสดงผลฝั่งลูกค้า",
    "พนักงาน",
    "สำรอง & กู้คืน ข้อมูล",
    "การเชื่อมต่อข้อมูล",
    "ระบบสมาชิก",
    "แจ้งปัญหาการใช้งาน",
    "บัญชีร้านค้า",
  ];
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
        title: Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text(
                'การตั้งค่า',
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  listTitle[currenIndex],
                  style: const TextStyle(color: Colors.black54, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (currenIndex == 7)
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
        //
      ),
      //Appbar Stop
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
                            for (int i = 0; i < 5; i++)
                              InkWell(
                                onTap: () => setState(() {
                                  currenIndex = i;
                                }),
                                child: btn(
                                  image: sideClick[i]['image'],
                                  text: sideClick[i]['text'],
                                ),
                              ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            //
                            for (int i = 5; i < 8; i++)
                              InkWell(
                                onTap: () => setState(() {
                                  currenIndex = i;
                                }),
                                child: btn(
                                  image: sideClick[i]['image'],
                                  text: sideClick[i]['text'],
                                ),
                              ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            //
                            for (int i = 8; i < 10; i++)
                              InkWell(
                                onTap: () => setState(() {
                                  currenIndex = i;
                                }),
                                child: btn(
                                  image: sideClick[i]['image'],
                                  text: sideClick[i]['text'],
                                ),
                              ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            //
                            for (int i = 10; i < sideClick.length; i++)
                              InkWell(
                                onTap: () => setState(() {
                                  currenIndex = i;
                                }),
                                child: btn(
                                  image: sideClick[i]['image'],
                                  text: sideClick[i]['text'],
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  )),
              Expanded(flex: 5, child: listPage[currenIndex]),
            ],
          ),
        ),
      ),
    );
  }

  ListTile btn({
    required String image,
    required String text,
  }) {
    return ListTile(
      leading: Container(
        width: 25,
        height: 25,
        child: Image.asset(image),
      ),
      title: Text(
        text,
        style: const TextStyle(color: Colors.black87, fontSize: 15),
      ),
    );
  }
}
