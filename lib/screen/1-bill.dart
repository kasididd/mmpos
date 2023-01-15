import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/widget/drawer_widget.dart';
import 'package:provider/provider.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
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
          'ประวัติการขาย',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
      ),
      //Appbar Stop
      body: SafeArea(
          child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .4,
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: Colors.red,
                        ),
                        Container(
                            width: 50,
                            child: Center(
                                child: Text(
                              'วันนี้',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 101, 91)),
                            ))),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Colors.red,
                        ),
                      ]),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.grey.shade400,
          ))
        ],
      )),
    );
  }
}
