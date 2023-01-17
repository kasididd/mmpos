import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mmpos/auth/login_page.dart';
import 'package:mmpos/page/2-main_page.dart';
import 'package:mmpos/provider/store.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => login ? MainPage() : LoginPage())));
    }
  }

  bool login = false;
  bool check = true;
  checkLogin(provider) async {
    if (check) {
      await provider.hiveRe();

      if (provider.email != null) {
        if (provider.email['email'] != "logout") login = true;
        check = false;
        print(provider.email);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Store provider = context.watch<Store>();
    if (check) checkLogin(provider);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.white,
            Colors.white,
            Colors.white,
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //Body Start

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Title Start
            Text(
              'Welcome To You',
              style: TextStyle(fontSize: 20),
            ),
            //Title Stop

            SizedBox(
              height: 10,
            ),

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

            //Text Start

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Start MMPOS Application',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),

            //Text Stop

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ],
        ),

        //Body Stop
      ),
    );
  }
}
