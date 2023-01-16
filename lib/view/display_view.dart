import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class DisplayView extends StatefulWidget {
  const DisplayView({super.key});

  @override
  State<DisplayView> createState() => _DisplayViewState();
}

class _DisplayViewState extends State<DisplayView> {
  //
  DateTime time_thai = DateTime.now();
  //

  @override
  Widget build(BuildContext context) {
    //Dateformat ไทย Start
    var formatter = DateFormat.yMMMM();
    //Dateformat ไทย Stop
    return Scaffold(
      appBar: AppBar(),
      //
      body: Container(
        child: Row(
          children: [
            Container(
              //
              width: MediaQuery.of(context).size.width * 0.50,
              //
              color: Colors.white,
              child: Column(
                children: [
                  //
                  Row(
                    children: [
                      Text(
                        '${time_thai.hour}:${time_thai.minute}:${time_thai.second}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  //
                  Row(
                    children: [
                      Text(
                        '${time_thai.day} ${formatter.format(time_thai)}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  //
                  SizedBox(
                    height: 150,
                  ),
                  //
                  Column(
                    children: [
                      Icon(
                        Icons.point_of_sale,
                        size: 120,
                        color: Colors.red,
                      ),
                      Text(
                        'MMPOS',
                        style: TextStyle(fontSize: 40),
                      ),
                    ],
                  ),

                  //
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.point_of_sale,
                                  color: Colors.red,
                                  size: 50,
                                ),
                                Row(
                                  children: [
                                    Text('MMPOS \n Powered by BBSystem')
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
            Container(
              width: MediaQuery.of(context).size.width * 0.50,
              height: double.infinity,
              child: Column(
                children: [
                  //
                  Card(
                    //
                    elevation: 0,
                    //
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            //
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //
                            children: [
                              Text(
                                'รวม',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '00.00',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '00.00',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                        width: double.infinity, height: 60, color: Colors.teal),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                        width: double.infinity, height: 60, color: Colors.teal),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                        width: double.infinity, height: 60, color: Colors.teal),
                  ),
                  //
                ],
              ),
            ),
            //
          ],
        ),
      ),
      //
    );
  }
}
