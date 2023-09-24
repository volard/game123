import 'package:flutter/services.dart';
import 'package:game123/game_ui_binding.dart';
import 'package:flutter/material.dart';
import 'package:game123/controllers/settings_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  await GetStorage.init();
  Get.put(SettingsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    final controller = Get.find<SettingsController>();
    return GetMaterialApp(
      title: '123 Game',
      initialBinding: GameUiBinding(),
      debugShowCheckedModeBanner: true,
      theme: controller.themeData,
      home: const HomePage(),
    );
  }
}


