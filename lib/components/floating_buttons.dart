import 'package:flutter/material.dart';
import 'package:game123/game_ui_controller.dart';
import 'package:game123/ui.dart';
import 'package:get/get.dart';
import '../game.dart';
import '../settings_controller.dart';

var cancelFloatingButton = FloatingActionButton(
  onPressed: () {
    stopDivisionMove();
    Get.find<GameUiController>().barChartData = Get.find<GameUiController>().getBarChartData();
    Get.find<GameUiController>().update();
  },
  child: const Icon(Icons.cancel),
);

var restartFloatingButton = FloatingActionButton(
  onPressed: () {
    restart();
    customCarouselController.jumpToPage(0);
    Get.find<GameUiController>().barChartData = Get.find<GameUiController>().getBarChartData();
    Get.find<GameUiController>().update();
  },
  child: const Icon(Icons.restart_alt),
);

var changeThemeFloatingButton = FloatingActionButton(
  onPressed: () {
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    Get.find<SettingsController>().storeThemeSetting(isDark: Get.isDarkMode);
    Get.find<GameUiController>().update();
  },
  child: Get.isDarkMode ? const Icon(Icons.sunny) : const Icon(
      Icons.nightlight),
);