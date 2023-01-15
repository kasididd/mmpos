import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:mmpos/page/1-welcome_page.dart';
import 'package:mmpos/page/2-main_page.dart';
import 'package:mmpos/provider/store.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Store(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MMPOS',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme)),
      home: WelcomePage(),
    );
  }
}
