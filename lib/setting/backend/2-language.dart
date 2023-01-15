import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
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
          'ตั้งค่าภาษา',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
      ),
      //Appbar Stop

      body: Column(
        children: [
          //Card 1 Start
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Card(
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              child: Image.network(
                                  'https://th.bing.com/th/id/R.cdac3cf461a577a8b436bf1ebf4258bf?rik=YwEdxCSUljts4A&riu=http%3a%2f%2fmommymaleta.com%2fwp-content%2fuploads%2f2015%2f06%2fThailand-1024x699.png&ehk=i8aK3QL5ZXqRf%2bQnWEYJOrHcel%2fuiCpj5j4wlCfUPRc%3d&risl=&pid=ImgRaw&r=0'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('ไทย',
                                  style: TextStyle(color: Colors.black87)),
                            ),
                          ],
                        ),
                        Container(
                          width: 200,
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                  //

                  //
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              child: Image.network(
                                  'https://cdn.pixabay.com/photo/2012/04/10/16/14/union-jack-26119__480.png'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('English',
                                  style: TextStyle(color: Colors.black87)),
                            ),
                          ],
                        ),
                        Container(
                          width: 200,
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //Card 1 Stop
        ],
      ),
    );
  }
}
