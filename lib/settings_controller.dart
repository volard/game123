import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  late ThemeData themeData;
  final _themeKey = 'isDark';

  final box = GetStorage();

  @override // called when Get.put before running app
  void onInit() {
    super.onInit();
    _restoreTheme();
  }

  void _restoreTheme() {
    bool isDark = box.read(_themeKey) ?? true;
    themeData = isDark ? ThemeData.dark() : ThemeData.light();
  }

  void storeThemeSetting({required bool isDark}) {
    box.write(_themeKey, isDark);
  }
}