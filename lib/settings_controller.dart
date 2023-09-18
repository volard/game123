import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  late ThemeData themeData;
  final _themeKey = 'isDark';

  final storage = GetStorage();

  @override // called when Get.put before running app
  void onInit() {
    super.onInit();
    _restoreTheme();
  }

  void _restoreTheme() {
    bool isDark = storage.read(_themeKey) ?? Get.isDarkMode;
    themeData = isDark ? ThemeData.dark() : ThemeData.light();
  }

  void changeTheme() {
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    storeThemeSetting(isDark: Get.isDarkMode);
  }

  void storeThemeSetting({required bool isDark}) {
    storage.write(_themeKey, isDark);
  }
}