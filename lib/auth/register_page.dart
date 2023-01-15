import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/auth/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                    'สมัครสมาชิก',
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

              //Phone Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'เบอร์มือถือ',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),

              //Phone Stop

              SizedBox(
                height: 10,
              ),

              //Password Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
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

              SizedBox(
                height: 10,
              ),

              //Password1 Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'ยืนยันรหัสผ่าน',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),

              //Password1 Stop

              //ResetPassword Start

              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     TextButton(onPressed: () {}, child: Text('ลืมรหัสผ่าน'))
              //   ],
              // ),

              //ResetPassword Stop

              SizedBox(
                height: 10,
              ),

              //Login Button Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                    print('Login');
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

              //Login Button Stop

              SizedBox(
                height: 10,
              ),

              //Register Start

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'มีสมาชิกแล้ว ?',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                        print('Login');
                      },
                      child: Text(
                        'เข้าสู่ระบบ',
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
