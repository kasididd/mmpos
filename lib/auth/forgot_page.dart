import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/API/service_api.dart';
import 'package:mmpos/auth/login_page.dart';
import 'package:mmpos/auth/register_page.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  TextEditingController email = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
                    const Icon(
                      Icons.point_of_sale,
                      color: Colors.red,
                      size: 120,
                    ),
                  ],
                ),
              ),
              //Logo Stop

              const SizedBox(
                height: 20,
              ),

              //Text Start

              Center(
                  child: Column(
                children: [
                  const Text(
                    'ลืมรหัสผ่าน',
                    style: TextStyle(fontSize: 35),
                  ),
                ],
              )),

              //Text Stop

              const SizedBox(
                height: 10,
              ),

              //Email Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'อีเมล',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),

              //Email Stop

              const SizedBox(
                height: 10,
              ),

              //Reset Button Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPage(),
                        ));
                    UserStore.resetPassword(email: email.text.trim());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 87, 75),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'ส่งคำขอรีรหัสผ่าน',
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

              //Text Back Start

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ));
                            print('Back');
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.red,
                                size: 15,
                              ),
                              const Text(
                                'กลับเข้าสู่ระบบ',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              )

              //Text Back Stop
            ],
          ),
        ),
      ),
    );
  }
}
