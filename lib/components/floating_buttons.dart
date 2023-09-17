import 'package:flutter/material.dart';
import 'package:game123/game_ui_controller.dart';
import 'package:game123/ui.dart';
import 'package:get/get.dart';
import '../game.dart';
import '../settings_controller.dart';

FloatingActionButton cancelFloatingButton() => FloatingActionButton(
  onPressed: () {
    stopDivisionMove();
    Get.find<GameUiController>().barChartData = Get.find<GameUiController>().getBarChartData();
    Get.find<GameUiController>().update();
  },
  child: const Icon(Icons.cancel),
);

FloatingActionButton restartFloatingButton() => FloatingActionButton(
  onPressed: () {
    restart();
    customCarouselController.jumpToPage(0);
    Get.find<GameUiController>().barChartData = Get.find<GameUiController>().getBarChartData();
    Get.find<GameUiController>().update();
  },
  child: const Icon(Icons.restart_alt),
);

FloatingActionButton changeThemeFloatingButton() => FloatingActionButton(
  onPressed: () {
    debugPrint(Get.isDarkMode.toString());
    // Get.changeTheme(ThemeData.light(useMaterial3: true));
    // Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    Get.find<SettingsController>().changeTheme();
    Get.find<SettingsController>().update();
    Get.find<GameUiController>().update();
  },
  child: Get.isDarkMode ? Icon(Icons.sunny) : Icon(
      Icons.nightlight),
);