import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/widget/drawer_widget.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  //
  DateTime time_thai = DateTime.now();
  //
  int select = 0;
  String type_store = "วันนี้";
  //

  @override
  Widget build(BuildContext context) {
    //Dateformat ไทย Start
    var formatter = DateFormat.yMMMM();
    //Dateformat ไทย Stop
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
          'แดชบอร์ดการขาย',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
      ),
      //Appbar Stop

      body: Column(
        children: [
          //
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(3)),
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 35,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SelectType(context, 0, 'วันนี้'),
                            SelectType(context, 1, 'สัปดาห์นี้'),
                            SelectType(context, 2, 'เดือนนี้'),
                            SelectType(context, 3, 'ปีนี้'),
                            SelectType(context, 4, 'กำหนดเอง'),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Row(
              //
              mainAxisAlignment: MainAxisAlignment.end,
              //
              children: [
                Text('${time_thai.day} ${formatter.format(time_thai)}')
              ],
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    //
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    children: [
                      Text('ขายได้วันนี้'),
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: Colors.red,
                            size: 23,
                          ),
                          Text(
                            '0.00',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    //
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    children: [
                      Text('กำไร'),
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: Colors.red,
                            size: 23,
                          ),
                          Text(
                            '0.00',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    //
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    children: [
                      Text('จำนวนบิล'),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.doc,
                            color: Colors.red,
                            size: 23,
                          ),
                          Text(
                            '0.00',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    //
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    children: [
                      Text('เฉลี่ย/บิล'),
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: Colors.red,
                            size: 23,
                          ),
                          Text(
                            '0.00',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                )
                //
              ],
            ),
          )
          //
        ],
      ),
    );
  }

  //SelectType Start

  GestureDetector SelectType(BuildContext context, index, String text1) {
    return GestureDetector(
      onTap: () => setState(() {
        select = index;
        type_store = text1;
      }),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: (MediaQuery.of(context).size.width * 0.15),
          height: double.infinity,
          decoration: BoxDecoration(
              color: select == index ? Colors.white : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Text(
            text1,
            style: TextStyle(fontSize: 13),
          )),
        ),
      ),
    );
  }

  //SelectType Stop

}
