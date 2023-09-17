import 'package:flutter/material.dart';
import 'package:game123/game_ui_controller.dart';
import 'package:get/get.dart';
import '../game.dart';

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
    Get.find<GameUiController>().barChartData = Get.find<GameUiController>().getBarChartData();
    Get.find<GameUiController>().update();
  },
  child: const Icon(Icons.restart_alt),
);

var changeThemeFloatingButton = FloatingActionButton(
  onPressed: () {
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    Get.find<GameUiController>().update();
  },
  child: Get.isDarkMode ? const Icon(Icons.sunny) : const Icon(
      Icons.nightlight),
);