import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
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
                      Icons.close,
                      color: Colors.red,
                      size: 20,
                    ),
                  ],
                ))
          ],
        ),
        //
        title: Text(
          'สร้างสินค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        //
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'บันทึก',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
        //
      ),
      //Appbar Stop

      //
      body: Column(
        children: [
          //
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  color: Colors.red,
                )
              ],
            ),
          ),
          //
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
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
                      hintText: 'ชื่อสินค้า',
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 200,
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
                        hintText: 'ราคา',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 200,
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
                        hintText: 'รหัสสินค้า',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.barcode_viewfinder,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              //
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      isExpanded: true,
                      items: <String>[
                        '1 km',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('data'),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                //
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      isExpanded: true,
                      items: <String>[
                        'กระบอก',
                        'กระปุก',
                        'กระป๋อง',
                        'กระสอบ',
                        'กระเช้า',
                        'กล่อง',
                        'ก้อน',
                        'ชิ้น',
                        'ซอง',
                        'ด้าม',
                        'ถุง',
                        'ปอนด์',
                        'ฟอง',
                        'ลัง',
                        'หลอด',
                        'แกลลอน',
                        'แท่ง',
                        'เเพ็ค',
                        'ใบ',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        'ชิ้น',
                        style: TextStyle(color: Colors.black),
                      ),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              //
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      isExpanded: true,
                      items: <String>[
                        'สินค้าทั่วไป',
                        'สินค้าประกอบ(BOM)',
                        'สินค้ามี Serial',
                        'สินค้าบริการ (สินค้าไม่มีสต๊อก)',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('สินค้าทั่วไป',
                          style: TextStyle(color: Colors.black)),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                //
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      isExpanded: true,
                      items: <String>[
                        'สินค้าทั่วไป',
                        'สินค้าประกอบ(BOM)',
                        'สินค้ามี Serial',
                        'สินค้าบริการ (สินค้าไม่มีสต๊อก)',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('', style: TextStyle(color: Colors.black)),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ],
      ),
      //
    );
  }
}
