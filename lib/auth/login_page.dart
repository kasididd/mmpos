import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/auth/forgot_page.dart';
import 'package:mmpos/auth/register_page.dart';
import 'package:mmpos/layout/phone.dart';
import 'package:mmpos/page/2-main_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Auth Start

  TextEditingController _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Future LoginComplete() async {
  //   var urls = "http://192.168.10.106/login.php";
  //   var response = await http.post(urls, body: {
  //     "email": _emailController.text,
  //     "password": _passwordController.text,
  //   });
  // }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  //Auth Stop

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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

              //Text Start

              Center(
                  child: Column(
                children: [
                  Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(fontSize: 35),
                  ),
                ],
              )),

              //Text Stop

              SizedBox(
                height: 10,
              ),

              //Email Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  //
                  controller: _emailController,
                  //
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'อีเมล',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),

              //Email Stop

              SizedBox(
                height: 10,
              ),

              //Password Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  //
                  obscureText: true,
                  controller: _passwordController,
                  //
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'รหัสผ่าน',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),

              //Password Stop

              //ResetPassword Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPage(),
                              ));
                          print('ResetPassword');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock,
                              color: Colors.red,
                              size: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ลืมรหัสผ่าน',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),

              //ResetPassword Stop

              SizedBox(
                height: 10,
              ),

              //Login Button Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ));
                      print('MainPage');
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 87, 75),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //Login Button Stop

              SizedBox(
                height: 10,
              ),

              //Register Start

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ยังไม่มีสมาชิก ?',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                        print('Register');
                      },
                      child: Text(
                        'สมัครสมาชิก',
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      ))
                ],
              )

              //Register Stop
            ],
          ),
        ),
      ),
    );
  }
}
