import 'package:game123/game_ui_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '123 Game',
      initialBinding: GameUiBinding(),
      debugShowCheckedModeBanner: true,
      theme: Get.isDarkMode? ThemeData.light(): ThemeData.dark(),
      home: const HomePage(),
    );
  }
}


