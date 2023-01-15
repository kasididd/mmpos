import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PhonePayment extends StatefulWidget {
  const PhonePayment({super.key});

  @override
  State<PhonePayment> createState() => _PhonePaymentState();
}

class _PhonePaymentState extends State<PhonePayment> {
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Colors.red,
          ),
        ),
        //
      ),
      //Appbar Stop

      //
      body: Column(
        children: [
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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    //
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    children: [
                      Text('รวมก่อนลด'),
                      Text('0.00'),
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    //
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    children: [
                      Text('THB'),
                      Text(
                        '0.00',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                      //
                      width: double.infinity,
                      height: 35,
                      //
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            //
                            showCupertinoModalBottomSheet(
                              expand: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => PaymentComplete(),
                            );
                            //
                          },
                          child: Text('ชำระเงิน'))),
                )
                //
              ],
            ),
          )
          //
        ],
      ),
      //
    );
  }
}

class PaymentComplete extends StatefulWidget {
  const PaymentComplete({super.key});

  @override
  State<PaymentComplete> createState() => _PaymentCompleteState();
}

class _PaymentCompleteState extends State<PaymentComplete> {
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        //
        title: Text(
          'การชำระเงิน',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
      ),
      //Appbar Stop

      //
      body: Column(
        children: [
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
                      Text('รวมสุทธิ'),
                      Text('00.00'),
                    ],
                  ),
                ),
                //
                //
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    //
                    mainAxisAlignment: MainAxisAlignment.end,
                    //
                    children: [
                      Text(
                        '00.00',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                //
              ],
            ),
            //
          ),
          //
          Container(
            //
            width: double.infinity,
            //
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text('ยืนยันการชำระเงิน')),
          )
          //
        ],
      ),
      //
    );
  }
}
