import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/widget/drawer_widget.dart';
import 'package:provider/provider.dart';

class DollarScreen extends StatefulWidget {
  const DollarScreen({super.key});

  @override
  State<DollarScreen> createState() => _DollarScreenState();
}

class _DollarScreenState extends State<DollarScreen> {
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
                  icon: Icon(
                    Icons.menu,
                    color: Colors.red,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer()),
        ),
        //
        title: Text(
          'รอบลิ้นชักเก็บเงิน',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
      ),
      //Appbar Stop

      //
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Card(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('รอบขายที่'),
                        Text('1'),
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
                        Text('เงินทอนเริ่มต้น'),
                        Text('50'),
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
                        Text('เวลาเปิดรอบขาย'),
                        Text('11/1/2023 10:12'),
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
                        Text('เปิดรอบขายโดย'),
                        Text('Admin'),
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Card(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ยอดขายด้วยเงินสด'),
                        Text('0.00'),
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
                        Text('ยอดรวมเงินเข้า'),
                        Text('0.00'),
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
                        Text('ยอดรวมเงินออก'),
                        Text('0.00'),
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
                        Text('จำนวนเงินที่ควรมีในลิ้นชัก'),
                        Text('0.00'),
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, elevation: 0),
                      onPressed: () {},
                      child: Text(
                        'นำเงินเข้าลิ้นชัก',
                        style: TextStyle(color: Colors.green),
                      )),
                ),
                Container(
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, elevation: 0),
                      onPressed: () {},
                      child: Text(
                        'นำเงินออกจากลิ้นชัก',
                        style: TextStyle(color: Colors.red),
                      )),
                ),
                //
              ],
            ),
          ),
          Container(
              width: double.infinity,
              height: 60,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {},
                    child: Text('ปิดรอบการขาย')),
              ))
        ],
      ),
      //
    );
  }
}
