import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mmpos/provider/store.dart';
import 'package:mmpos/screen/7_product_screen.dart';
import 'package:mmpos/widget/drawer_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  List stock = [];
  int bottom = 0;
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Store>();
    if (stock.isEmpty)
      setState(() {
        stock = provider.item!;
      });
    print(stock);
    return SafeArea(
        child: Scaffold(
      drawer: DrawerWidget(
        provider: provider,
      ),
      //Appbar Stop
      appBar: AppBar(
        //
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        //
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.red),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          'ความเคลื่อนไหวสินค้า',
          style: TextStyle(color: Colors.black54, fontSize: 17),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                bottom == 0 ? print("scan") : productScreenOpen(provider);
              },
              child: Icon(
                bottom == 0 ? Icons.qr_code_scanner_rounded : Icons.add,
                color: Colors.red,
              )),
        ],
      ),
      //Appbar Stop
      backgroundColor: Colors.white,
      // body here
      body:

          // row big 2
          Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            // col 1
            child: Container(
              width: 340,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 2,
                              color: Colors.grey.shade300)
                        ],
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(0)),
                    child: Center(
                      child: SearchField(
                        onSuggestionTap: (p0) => print("แค่แตะ 😅"),
                        onSubmit: (p0) => print("นี่คือ 👌 P0: ${p0}"),
                        searchInputDecoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
                          hintText: 'ค้นหาสินค้าทั้งหมด...',
                        ),
                        itemHeight: 50,
                        maxSuggestionsInViewPort: 7,
                        suggestionsDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suggestions: stock
                            .map(
                              (e) => SearchFieldListItem(e['name'],
                                  item: e['name'],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(e['name']),
                                  )),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  for (var data in provider.cate)
                    Slidable(
                      endActionPane:
                          ActionPane(motion: StretchMotion(), children: [
                        SlidableAction(
                          onPressed: (context) {
                            print('${data['id'].runtimeType}');
                            // print('${int.parse(data['id']).runtimeType}');
                            // provider.hiveDeleteCate(
                            //   index_: data['id'],
                            // );
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                        )
                      ]),
                      child: ListTile(
                          leading: Icon(Icons.circle),
                          title: Text(data['name'].toString())),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: provider.item!.length,
            itemBuilder: (context, index) => ListTile(
              leading: Text(''),
              title: Text(provider.item![index]['name']),
            ),
          ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 20,
        // fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'ความเคลื่อนไหวสินค้า'),
          BottomNavigationBarItem(
              icon: Icon(Icons.move_to_inbox_outlined), label: 'รับสินค้าเข้า'),
          BottomNavigationBarItem(
              icon: Icon(Icons.outbox_outlined), label: 'จ่ายสินค้าออก'),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_sharp),
            label: 'ปรับปรุงสต๊อก',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_business_outlined), label: 'ตรวจนับสินค้า'),
        ],
        currentIndex: bottom,
        onTap: (value) => setState(() {
          bottom = value;
        }),
      ),
    ));
  }

  productScreenOpen(Store provider) async {
    await showBarModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductScreen(),
    );
  }
}
