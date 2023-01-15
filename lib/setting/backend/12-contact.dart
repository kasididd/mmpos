import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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
          'ติดต่อ',
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Card(
              //
              elevation: 0,
              //
              child: Column(
                children: [
                  // Logo Start
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.point_of_sale,
                          color: Colors.red,
                          size: 120,
                        ),
                      ],
                    ),
                  ),
                  //Logo Stop

                  SizedBox(
                    height: 20,
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MMPOS',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'เบอร์ติดต่อ',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Text('0968011934')
                    ],
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'เพจ',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Text('@MMPOS')
                    ],
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 125,
                        height: 125,
                        child: Image.asset('assets/images/qrcode.jpg'),
                      )
                    ],
                  ),
                  //
                ],
              ),
            ),
          )
          //
        ],
      ),
      //
    );
  }
}
