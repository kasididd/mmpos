import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PaymentSetting extends StatefulWidget {
  const PaymentSetting({super.key});

  @override
  State<PaymentSetting> createState() => _PaymentSettingState();
}

class _PaymentSettingState extends State<PaymentSetting> {
  bool _switchValue = true;

  bool credit = false;
  bool promtpay = false;
  bool coupon = false;
  bool mudjum = false;
  bool edit = false;

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
                'ตั้งค่าชำระเงิน',
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 3),
                        child: Row(
                          children: [
                            Text('Quick Cash Payment'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 65,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: '20',
                                ),
                              ),
                            ),
                            //
                            Container(
                              width: 65,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: '50',
                                ),
                              ),
                            ),
                            //
                            Container(
                              width: 65,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: '100',
                                ),
                              ),
                            ),
                            //
                            Container(
                              width: 65,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: '500',
                                ),
                              ),
                            ),
                            Container(
                              width: 65,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: '1000',
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          //Card 1 Stop

          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text('ประเภทการชำเงิน'),
              )
            ],
          ),
          //Card 2 Start

          Card(
            elevation: 0,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/credit.png')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('บัตรเครดิต/เดบิต'),
                          ),
                        ],
                      ),
                      //Switch Start
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        borderRadius: 10.0,
                        activeColor: Colors.red,
                        value: credit,
                        onToggle: (value) {
                          setState(() {
                            credit = value;
                          });
                        },
                      ),
                      //Switch Stop
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 25,
                              height: 25,
                              child:
                                  Image.asset('assets/icons/prompt-pay.jpg')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('พร้อมเพย์'),
                          ),
                        ],
                      ),
                      //Switch Start
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        borderRadius: 10.0,
                        activeColor: Colors.red,
                        value: promtpay,
                        onToggle: (value) {
                          setState(() {
                            promtpay = value;
                          });
                        },
                      ),
                      //Switch Stop
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 25,
                              height: 25,
                              child: Image.network(
                                  'https://www.pngall.com/wp-content/uploads/12/Voucher-Coupon-Card.png')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('คูปอง'),
                          ),
                        ],
                      ),
                      //Switch Start
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        borderRadius: 10.0,
                        activeColor: Colors.red,
                        value: coupon,
                        onToggle: (value) {
                          setState(() {
                            coupon = value;
                          });
                        },
                      ),
                      //Switch Stop
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 25,
                              height: 25,
                              child: Image.network(
                                  'https://v4i.rweb-images.com/www.coopindustry.com/images/content/original-1548074076835.png')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('มัดจำ'),
                          ),
                        ],
                      ),
                      //Switch Start
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        borderRadius: 10.0,
                        activeColor: Colors.red,
                        value: mudjum,
                        onToggle: (value) {
                          setState(() {
                            mudjum = value;
                          });
                        },
                      ),
                      //Switch Stop
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 25,
                              height: 25,
                              child: Image.network(
                                  'https://www.pholiday.com/ckfinder/userfiles/images/%E0%B9%80%E0%B8%87%E0%B8%B4%E0%B8%991(1).png')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('กำหนดเอง'),
                          ),
                        ],
                      ),
                      //Switch Start
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        borderRadius: 10.0,
                        activeColor: Colors.red,
                        value: edit,
                        onToggle: (value) {
                          setState(() {
                            edit = value;
                          });
                        },
                      ),
                      //Switch Stop
                    ],
                  ),
                )
              ],
            ),
          ),
          //

          //Card 2 Stop
        ],
      ),
      //
    );
  }
}
