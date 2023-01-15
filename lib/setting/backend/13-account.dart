import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade200,
      //

      //Appbar Start
      appBar: AppBar(
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
          'บัญชีร้านค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
      ),
      //Appbar Stop

      //
      body: Column(
        children: [
          //Card 1 Start
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Card(
              //
              elevation: 0,
              //
              child: Column(
                children: [
                  //
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 124,
                          height: 50,
                          color: Colors.yellow,
                        ),
                        //
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'MMPOS',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text('Email'),
                  Text('**************')
                ],
              ),
            ),
          ),
          //Card 1 Stop

          //Card 2 Start

          Card(
            //
            elevation: 0,
            //
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                  label: Text(
                    'ออกจากระบบ',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          )

          //Card 2 Stop
        ],
      ),
      //
    );
  }
}
