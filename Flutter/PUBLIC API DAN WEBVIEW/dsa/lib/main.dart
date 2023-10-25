import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prak/Page/Home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recipe App',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
