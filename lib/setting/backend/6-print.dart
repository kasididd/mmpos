import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/src/print/printer_add.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PrintSetting extends StatefulWidget {
  const PrintSetting({super.key});

  @override
  State<PrintSetting> createState() => _PrintSettingState();
}

class _PrintSettingState extends State<PrintSetting> {
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
                'ตั้งค่าใบเสร็จรับเงิน',
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              centerTitle: true,
              //
              actions: [
                TextButton(
                    onPressed: () {
                      //
                      showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => PrintAdd(),
                      );
                      //
                    },
                    child: Text(
                      'เพิ่มอุปกรณ์',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
      //Appbar Stop
    );
  }
}
