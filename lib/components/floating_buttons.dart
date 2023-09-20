import 'package:flutter/material.dart';
import 'package:game123/controllers/game_ui_controller.dart';
import 'package:get/get.dart';
import '../controllers/elements_controllers.dart';
import '../game/game_logic.dart';
import '../controllers/settings_controller.dart';
import 'game_field.dart';

List<Widget> floatingButtons() {
  var buttons = [
    restartFloatingButton(),
    const SizedBox(height: 10,),
    changeThemeFloatingButton(),
    const SizedBox(height: 10,),
  ];

  if (isDivisionMovePerforming()) buttons.add(cancelFloatingButton());
  return buttons;
}

FloatingActionButton cancelFloatingButton() => FloatingActionButton(
  onPressed: () {
    stopDivisionMove();
    Get.find<GameUiController>().gameWidget = gameField();
    Get.find<GameUiController>().update();
  },
  child: const Icon(Icons.cancel),
);

FloatingActionButton restartFloatingButton() => FloatingActionButton(
  onPressed: () {
    restart();
    customCarouselController.jumpToPage(0);
    Get.find<GameUiController>().gameWidget = gameField();
    Get.find<GameUiController>().update();
  },
  child: const Icon(Icons.refresh),
);

FloatingActionButton changeThemeFloatingButton() => FloatingActionButton(
  onPressed: () {
    Get.find<SettingsController>().changeTheme();
  },
  child: Get.isDarkMode ? const Icon(Icons.sunny) : const Icon(
      Icons.nightlight),
);