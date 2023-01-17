import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mmpos/API/service_api.dart';

class Store with ChangeNotifier {
  // iamge
  File? iamge;

  List itemList = [
    // {
    //   "image": 'items/1.png',
    //   "title": 'ข้าวผัด',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
    // {
    //   "image": 'items/1.png',
    //   "title": 'ผัดกระเพรา',
    //   "qty": '1',
    //   "price": '50',
    //   "cate": "food"
    // },
  ];
  List itemOrdeList = [
    // {"image": 'items/1.png', "title": 'Orginal Burger', "qty": 2, "price": 5},
    // {"image": 'items/2.png', "title": 'Double Burger', "qty": 3, "price": 10},
    // {
    //   "image": 'items/6.png',
    //   "title": 'Special Black Burger',
    //   "qty": 2,
    //   "price": 8
    // },
    // {
    //   "image": 'items/4.png',
    //   "title": 'Special Cheese Burger',
    //   "qty": 2,
    //   "price": 12
    // }
  ];

  // int menuCount = 0;
  int sumAllResult = 0;
  List menuList = [
    // 'https://i.imgur.com/esFxnxJ.jpg', 'ผัดกระเพรา', 50, , 'history'
  ];
  List cate = [];

  addCate(list) {
    cate = list;
    notifyListeners();
  }

  deleteCate(name) {
    cate.removeWhere(
      (element) => element == name,
    );
    notifyListeners();
  }

  add(index) {
    menuList[index][3]++;
    notifyListeners();
  }

  remove(index) {
    if (menuList[index][3] > 0) {
      menuList[index][3]--;
    }
    notifyListeners();
  }

  addQty(index) {
    itemOrdeList[index]['qty']++;
    notifyListeners();
  }

  removeQty(index) {
    if (itemOrdeList[index]['qty'] > 0) {
      itemOrdeList[index]['qty']--;
    } else {
      itemOrdeList.removeAt(index);
    }
    notifyListeners();
  }

  priceSum(sum) {
    sumAllResult = sum;

    notifyListeners();
  }
// addMenulist
  // addMenuList(image, name, price, cate) {
  //   if (image != null && name != null && price != null && cate != null) {
  //     itemList.add([image, name, int.parse(price), 0, cate]);
  //     print(menuList);
  //     notifyListeners();
  //   }
  // }

  additemOrdeList(item, index) {
    List<dynamic> have = itemOrdeList
        .where((element) => element['title'] == item['title'])
        .toList();
    have.length != 0
        // ignore: unnecessary_statements
        ? {
            print(have[0]['qty'].runtimeType),
            have[0]['qty'] = (have[0]['qty'] + 1)
          }
        : itemOrdeList.add(item);

    notifyListeners();
  }

  countSum() {
    int sumMultiple = 0;
    for (var item in itemOrdeList) {
      int qty = item['qty'];
      int price = item['price'];
      sumMultiple += qty * price;
      print(sumMultiple.toString());
    }
    sumAllResult = sumMultiple;
    print(sumMultiple);
  }

  Future deleteFile(String path) async {
    await File(path).delete();
    notifyListeners();
  }

  sumFunc() {
    int sumAll = 0;
    for (int i = 0; i < menuList.length; i++) {
      int price = menuList[i][2] * menuList[i][3];
      sumAll += price;
    }
    priceSum(sumAll);
    notifyListeners();
  }

  // login
  int countC = 0;
  String state = '_';
  List users = [
    {"userName": 'admin', "password": "123456"},
    {"userName": 'admin', "password": "123456"},
  ];

  String base64 = '';
  getPromt() {
    base64 = '';
    print(GetAPI.genQrProm(name: 'name'));
  }

  Color? colorsPicked;
  bool? onOff;

  // mainOrder
  List orderList = [];

  addOrderList(Object) {}

  // setting
  bool secondScreen = false;
  setValSetting(action, val) {
    if (action == "openScreen") {
      bool secondScreen = val;
      print(secondScreen);
    }
  }

  String? table;
  getTable(get) {
    table = get;
    notifyListeners();
  }

  List? order;
  getOrder(get) {
    order = get;
    notifyListeners();
  }

  List? item;
  getItem(get) {
    item = get;
    notifyListeners();
  }

  List? userData;
  getUserData(List get) {
    userData = get;
    notifyListeners();
  }

  getCate(List get) {
    cate = get;
    notifyListeners();
  }

  // login
  dynamic email = '';
  hiveLogin(data) async {
    await Hive.initFlutter();
    await Hive.openBox('email');
    var emailHive = await Hive.box('email');
    emailHive.put(0, data);
    email = data;
    notifyListeners();
  }

  hiveRe() async {
    await Hive.initFlutter();
    await Hive.openBox('email');
    var emailHive = await Hive.box('email');
    email = await emailHive.get(0);
    if (email == null) {
      email = "_";
    }
    notifyListeners();
  }

  hiveLogout() async {
    await Hive.initFlutter();
    await Hive.openBox('email');
    var emailHive = await Hive.box('email');
    emailHive.put(0, {"email": "logout"});
    notifyListeners();
  }
}
