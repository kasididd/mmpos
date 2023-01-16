import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/view/display_view.dart';

class DisplaySetting extends StatefulWidget {
  const DisplaySetting({super.key});

  @override
  State<DisplaySetting> createState() => _DisplaySettingState();
}

class _DisplaySettingState extends State<DisplaySetting> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //
      backgroundColor: Colors.grey.shade200,
      //

      //Appbar Start
      appBar: size.width > size.height
          ? null
          : AppBar(
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
                'ตั้งค่าระบบแยกจอ',
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              centerTitle: true,
              //
            ),
      body: Center(
          child: TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DisplayView(),
                  )),
              child: Text("เปิดหน้าจอแยก"))),
      //Appbar Stop
    );
  }
}
