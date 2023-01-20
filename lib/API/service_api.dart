// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';
import '../provider/store.dart';

// String config = "103.141.68.48";
// String config = "192.168.24.159";
String config = "192.168.24.32";
String dblink = 'http://$config/mmposAPI/items_crud.php';
String slipLink = "http://$config/mmposAPI/slip_crud.php";
String cateLink = "http://$config/mmposAPI/cate_crud.php";
String customerLink = "http://$config/mmposAPI/customer.php";

class Insert {
  static Future insertU({required name}) async {
    var response = await http.post(Uri.parse(dblink),
        body: {"action_users": "INSERT", "name": name, "password": name});
    if (response.statusCode == 200) {
      print(response.body);

      return response.body;
    }
  }

  static Future insertItem({required name}) async {
    var response = await http.post(Uri.parse(dblink),
        body: {"action_users": "INSERT", "name": name, "password": name});
    if (response.statusCode == 200) {
      print(response.body);

      return response.body;
    }
  }
}

Future update(id, name) async {
  var response = await http.post(Uri.parse(dblink),
      body: {"action": "UPDATE", "id": id, "name": name});
  if (response.statusCode == 200) {
    return response.body;
  }
}

Future delete(id) async {
  var response =
      await http.post(Uri.parse(dblink), body: {"action": "DELETE", "id": id});
  if (response.statusCode == 200) {
    return response.body;
  }
}

Future read() async {
  var response = await http.get(
    Uri.parse('http://$config/demo/read.php'),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
}

Future getById(String id) async {
  var response =
      await http.post(Uri.parse(dblink), body: {"action": "GET", "id": id});
  if (response.statusCode == 200) {
    print(jsonDecode(response.body)[0]);
    return response.body;
  }
}

class GetAPI {
  // promtpay
  static genQrProm({
    required name,
  }) async {
    var response = await http.post(
        Uri.parse(
          'http://$config/mmposAPI/PromptPay-QR-generator-master/test.php',
        ),
        body: {
          "name": name,
        });
    if (response.statusCode == 200) {
      List base64 = response.body.split(",");
      print(base64[1]);
      return base64[1];
    }
  }
}

class DataBase {
  static Future insertU(
      {required String name,
      required String image,
      required String price,
      required String items_barcode,
      required String category,
      required String type,
      required String weight,
      required String check_list,
      required String is_use,
      required String is_show,
      required String cost,
      required String quantity,
      required Store provider}) async {
    // String list = check_list.map((e) => e['checkIn']).toList().join();
    var response = await http.post(
        Uri.parse(
          dblink,
        ),
        body: {
          "action": "INSERT",
          "name": name,
          "image": image,
          "price": price,
          "items_barcode": items_barcode,
          "category": category,
          "type": type,
          "weight": weight,
          "check_list": check_list,
          "is_use": is_use,
          "is_show": is_show,
          "cost": cost,
          "quantity": quantity,
          "email": provider.email['email']
        });
    if (response.statusCode == 200) {
      print(response.body);

      return response.body;
    }
  }

  static select() async {
    var response = await http
        .post(Uri.parse('http://$config/mmposAPI/items_crud.php'), body: {
      "action": "GET_ALL",
    });
    if (response.statusCode == 200) {
      // print(response.body);

      return jsonDecode(response.body);
    }
  }

  static delete({required u_id}) async {
    var response = await http
        .post(Uri.parse(dblink), body: {"action": "DELETE", "u_id": u_id});
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  static delete_id({required u_id, required String email}) async {
    var response = await http.post(Uri.parse(dblink),
        body: {"action": "USER_DELETE", "u_id": u_id, "email": email});
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  static Future update(
      {required String u_id,
      required String name,
      required String image,
      required String price,
      required String items_barcode,
      required String category,
      required String type,
      required String weight,
      required String check_list,
      required String is_use,
      required String is_show,
      required String cost,
      required String quantity,
      required String email}) async {
    // String list = check_list.map((e) => e['checkIn']).toList().join();
    var response = await http.post(Uri.parse(dblink), body: {
      "action": "UPDATE",
      "u_id": u_id,
      "name": name,
      "image": image,
      "price": price,
      "items_barcode": items_barcode,
      "category": category,
      "type": type,
      "weight": weight,
      "check_list": check_list,
      "is_use": is_use,
      "is_show": is_show,
      "cost": cost,
      "quantity": quantity,
      "email": email
    });
    if (response.statusCode == 200) {
      print(response.body);

      return response.body;
    }
  }
}

class Slip {
  static Future insertU({
    required String name_item,
    required String sum,
    required String email,
  }) async {
    try {
      print('insert');
      var response = await http.post(Uri.parse(slipLink), body: {
        "action": "INSERT",
        "name_item": name_item,
        "sum": sum,
        "email": email
      });
      if (response.statusCode == 200) {
        print(response.body);

        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  static select({required Store provider}) async {
    var response = await http.post(Uri.parse(slipLink), body: {
      "action": "GET_ALL",
      "email": provider.email['email'],
      "that_is": "cate",
    });
    if (response.statusCode == 200) {
      // print(response.body);
      var res = await jsonDecode(response.body);
      provider.getOrder(res);
      return res;
    }
  }

  static deleteAll({required String email}) async {
    var response = await http.post(Uri.parse(slipLink),
        body: {"action": "DELETE_All", "email": email});
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  static delete({required String u_id, required String email}) async {
    var response = await http.post(Uri.parse(slipLink),
        body: {"action": "DELETE", "u_id": u_id, "email": email});
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }
}

class Cate {
  static Future insertU(
      {required String name,
      required String color,
      required String that_is,
      required Store provider}) async {
    try {
      var response = await http.post(Uri.parse(cateLink), body: {
        "action": "INSERT",
        "name": name,
        "color": color,
        "that_is": that_is,
        "email": provider.email['email']
      });
      if (response.statusCode == 200) {
        print(response.body);

        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  static select({required String that_is, required String email}) async {
    var response = await http.post(Uri.parse(cateLink),
        body: {"action": "GET_ALL", "email": email, "that_is": that_is});
    if (response.statusCode == 200) {
      // print(response.body);

      return jsonDecode(response.body);
    }
  }

  static deleteAll({
    required String that_is,
    required String email,
  }) async {
    var response = await http.post(Uri.parse(cateLink),
        body: {"action": "DELETE_All", "email": email, "that_is": that_is});
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  static delete(
      {required u_id, required String that_is, required Store provider}) async {
    var response = await http.post(Uri.parse(cateLink), body: {
      "action": "DELETE",
      "u_id": u_id,
      "email": provider.email['email'],
      "that_is": that_is
    });
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }
}

class CateCustomer {
  Future insertU({required String name, required Store provider}) async {
    try {
      var response = await http.post(Uri.parse(cateLink), body: {
        "action": "INSERT",
        "name": name,
        "color": "",
        "that_is": "gr.customer",
        "email": provider.email['email']
      });
      if (response.statusCode == 200) {
        print(response.body);
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  select({required Store provider}) async {
    var response = await http.post(Uri.parse(cateLink), body: {
      "action": "GET_ALL",
      "email": provider.email['email'],
      "that_is": "gr.customer"
    });
    if (response.statusCode == 200) {
      // print(response.body);
      List res = await jsonDecode(response.body);
      provider.getCateGr(res);
      return jsonDecode(response.body);
    }
  }

  deleteAll({
    required String email,
  }) async {
    var response = await http.post(Uri.parse(cateLink), body: {
      "action": "DELETE_All",
      "email": email,
      "that_is": "gr.customer"
    });
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  delete({required u_id, required Store provider}) async {
    var response = await http.post(Uri.parse(cateLink), body: {
      "action": "DELETE",
      "u_id": u_id,
      "email": provider.email['email'],
      "that_is": "gr.customer"
    });
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }
}

class CustomerAPI {
  String customerLink = "http://$config/mmposAPI/customer.php";
  Future insertU({
    required String fname,
    required String lname,
    required String tel,
    required String sex,
    required String c_group,
    required String email,
    required String bday,
  }) async {
    try {
      print("sending");
      var response = await http.post(Uri.parse(customerLink), body: {
        "action": "INSERT",
        "email": email,
        "fname": fname,
        "lname": lname,
        "tel": tel,
        "sex": sex,
        "c_group": c_group,
        "bday": bday,
      });
      if (response.statusCode == 200) {
        print("sendsucess");
        print(response.body);

        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future updateCustomer({
    required String fname,
    required String lname,
    required String tel,
    required String sex,
    required String c_group,
    required String email,
    required String bday,
    required String u_id,
  }) async {
    try {
      print("sending");
      var response = await http.post(Uri.parse(customerLink), body: {
        "action": "UPDATE",
        "email": email,
        "fname": fname,
        "lname": lname,
        "tel": tel,
        "sex": sex,
        "c_group": c_group,
        "bday": bday,
        "u_id": u_id,
      });
      if (response.statusCode == 200) {
        print(response.body);

        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  select({required Store provider}) async {
    var response = await http.post(Uri.parse(customerLink),
        body: {"action": "GET_ALL", "email": provider.email['email']});
    if (response.statusCode == 200) {
      List res = await jsonDecode(response.body);
      provider.getCustomer(res);
      return;
    }
  }

  deleteAll() async {
    var response = await http.post(Uri.parse(customerLink), body: {
      "action": "DELETE_All",
    });
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  delete({required u_id, required String email}) async {
    var response = await http.post(Uri.parse(customerLink),
        body: {"action": "USER_DELETE", "u_id": u_id, "email": email});
    if (response.statusCode == 200) {
      return;
    }
  }
}

class EmpApi {
  String empLink = "http://$config/mmposAPI/employee.php";
  Future insertU({
    required String e_name,
    required String e_pass,
    required String setting1,
    required String setting2,
    required String image,
    required String email,
  }) async {
    try {
      print("sending");
      var response = await http.post(Uri.parse(empLink), body: {
        "action": "INSERT",
        "e_name": e_name,
        "e_pass": e_pass,
        "setting1": setting1,
        "setting2": setting2,
        "image": image,
        "email": email,
      });
      if (response.statusCode == 200) {
        print("sendsucess");
        print(response.body);

        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future update({
    required String u_id,
    required String e_name,
    required String e_pass,
    required String setting1,
    required String setting2,
    required String image,
    required String email,
  }) async {
    try {
      print("updating");
      var response = await http.post(Uri.parse(empLink), body: {
        "action": "UPDATE",
        "u_id": u_id,
        "e_name": e_name,
        "e_pass": e_pass,
        "setting1": setting1,
        "setting2": setting2,
        "image": image,
        "email": email,
      });
      if (response.statusCode == 200) {
        print(response.body);

        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  select({required String email, required Store provider}) async {
    var response = await http.post(Uri.parse(empLink), body: {
      "action": "GET_ALL",
      "email": email,
    });
    if (response.statusCode == 200) {
      // print(response.body);
      List res = await jsonDecode(response.body);
      provider.getEmp(res);
      return;
    }
  }

  deleteAll() async {
    var response = await http.post(Uri.parse(empLink), body: {
      "action": "DELETE_All",
    });
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  delete({required String u_id, required String email}) async {
    var response = await http.post(Uri.parse(empLink),
        body: {"action": "DELETE", "u_id": u_id, "email": email});
    if (response.statusCode == 200) {
      // print(response.body);
      print(response.body);
      return response.body;
    }
  }
}

class TableAPI {
  static String tableLink = "http://$config/mmposAPI/table_list.php";
  static Future insertU({
    required String name,
    required String email,
  }) async {
    try {
      print("sending");
      var response = await http.post(Uri.parse(tableLink), body: {
        "action": "INSERT",
        "email": email,
        "name": name,
      });
      if (response.statusCode == 200) {
        print("sendsucess");
        print(response.body);

        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  static select(email) async {
    var response = await http.post(Uri.parse(tableLink),
        body: {"action": "GET_ALL", "email": email});
    if (response.statusCode == 200) {
      // print(response.body);

      return jsonDecode(response.body);
    }
  }

  static deleteAll() async {
    var response = await http.post(Uri.parse(tableLink), body: {
      "action": "DELETE_All",
    });
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  static delete({required u_id}) async {
    var response = await http
        .post(Uri.parse(tableLink), body: {"action": "DELETE", "u_id": u_id});
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }
}

class UserStore {
  static String userLink = "http://$config/mmposAPI/user.php";
  static String userLoginLink = "http://$config/mmposAPI/login.php";
  static String tokenLink = "http://$config/mmposAPI/change_password/token.php";
  static Future update(
      {required String image,
      required String type_store,
      required String tax_id,
      required String pos_id,
      required String branch,
      required String m_id,
      required String time_open,
      required String time_close,
      required String tax_val,
      required String service_chage,
      required String is_doble,
      required String adress1_2,
      required String tel,
      required String name_store,
      required String tel_promt,
      required String setting,
      required String u_id,
      required String email}) async {
    try {
      print("sending");
      var response = await http.post(Uri.parse(userLink), body: {
        "action": "UPDATE",
        "u_id": u_id,
        "email": email,
        "name_store": name_store,
        "branch": branch,
        "tel_promt": tel_promt,
        "setting": setting,
        "image": image,
        "type_store": type_store,
        "tax_id": tax_id,
        "m_id": m_id,
        "time_open": time_open,
        "time_close": time_close,
        "tax_val": tax_val,
        "service_chage": service_chage,
        "is_doble": is_doble,
        "adress1_2": adress1_2,
        "pos_id": pos_id,
      });
      if (response.statusCode == 200) {
        print("internet 👌");
        print("ข้อมูล from data base : ${response.body}");

        return response.body;
      }
    } catch (e) {
      print("ไม่สามารถ อัปเดท Userได้ $e");
    }
  }

  static insert({
    required String email,
    required String password,
    required String tel_promt,
  }) async {
    var response = await http.post(Uri.parse(userLink), body: {
      "action": "INSERT",
      "email": email,
      "tel_promt": tel_promt,
      "password": password
    });
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  static login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(Uri.parse(userLoginLink), body: {
        "action": "SELECT",
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        // print(response.body);

        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  static getStore({
    required Store provider,
  }) async {
    try {
      var response = await http.post(Uri.parse(userLoginLink), body: {
        "action": "GETDATA",
        "email": provider.email['email'],
      });
      if (response.statusCode == 200) {
        // print(response.body);

        var res = await jsonDecode(response.body);
        provider.getUserData(res);
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  static resetPassword({
    required String email,
  }) async {
    String token = Random().nextInt(1000000).toString();
    try {
      var response = await http.post(Uri.parse(tokenLink), body: {
        "email": email,
        "token": token,
      });
      if (response.statusCode == 200) {
        // print(response.body);
        final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
        const service_id = "service_lgmfds4";
        const template_id = "template_0vcwepe";
        const user_id = "5Gjw1_A36I08CT46m";
        String to_email = email;
        String link =
            "http://$config/mmposAPI/change_password/?token=$token&email=$email";
        var res = await http.post(url,
            headers: {
              'origin': 'http:/localhost',
              'Content-Type': 'application/json'
            },
            body: json.encode({
              "service_id": service_id,
              "template_id": template_id,
              "user_id": user_id,
              "template_params": {"to_email": to_email, "link": link}
            }));
        print(res.body);
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  static deleteAll() async {
    var response = await http.post(Uri.parse(userLink), body: {
      "action": "DELETE_All",
    });
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }

  static delete({required u_id}) async {
    var response = await http
        .post(Uri.parse(userLink), body: {"action": "DELETE", "u_id": u_id});
    if (response.statusCode == 200) {
      // print(response.body);

      return response.body;
    }
  }
}

class GetRefress {
  static selectAll({
    required Store provider,
    required String email,
  }) async {
    var request = await http.post(
        Uri.parse('http://$config/mmposAPI/items_crud.php'),
        body: {"action": "GET_ALL", "email": email});

    if (request.statusCode == 200) {
      // print(response.body);
      var res = jsonDecode(request.body);

      provider.getItem(res);
    }

    var response = await http.post(Uri.parse(cateLink),
        body: {"action": "GET_ALL", "email": email, "that_is": "cate"});
    if (response.statusCode == 200) {
      // print(response.body);
      var res = jsonDecode(response.body);

      provider.getCate(res);
    }

    // slipCrude
  }
}

class myDecoder {
  static readColor(res) {
    String rgbSt = res;
    List get = rgbSt.split(",");
    // print("get   $get");
    return Color.fromARGB(
        255, int.parse(get[0]), int.parse(get[1]), int.parse(get[2]));
  }
}

class Utility {
  static phonCheck(context) {
    Size size = MediaQuery.of(context).size;
    bool phone = size.width < size.height;
    return phone;
  }

  SearchField searcher(
      {required String text,
      required List suggest,
      required TextEditingController search}) {
    return SearchField(
      controller: search,
      searchInputDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        border: InputBorder.none,
        icon: const Icon(Icons.search),
        hintText: text,
      ),
      itemHeight: 50,
      maxSuggestionsInViewPort: 7,
      suggestionsDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      suggestions: suggest
          .map(
            (element) => SearchFieldListItem(element.toString(),
                item: element,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(element.toString()),
                )),
          )
          .toList(),
    );
  }
}
