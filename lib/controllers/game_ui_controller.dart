import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game123/game/game_ui.dart';
import 'package:get/get.dart';

import '../components/game_field.dart';
import '../game/game_logic.dart';
import 'elements_controllers.dart';

class GameUiController extends GetxController {

  late var gameWidget = gameField();

  void handleHover(event, BarTouchResponse? barResponse) {
    // Add animations on hover
    if (event is! FlPointerHoverEvent &&
        event is! FlPointerExitEvent &&
        event is! FlPointerEnterEvent) return;

    if (barResponse != null && barResponse.spot != null) {
      // No meaning in hovering second part of halved heap
      if (barResponse.spot!.touchedRodDataIndex != 0 || event is FlPointerExitEvent) {
        hoveredHeap = -1;
      } else {
        hoveredHeap = barResponse.spot!.touchedBarGroupIndex.toInt();
      }
    } else {
      hoveredHeap = -1;
    }
    gameWidget = gameField();
    update();
  }

  void handleTouch(event, BarTouchResponse? barResponse) {

    if (getGameStatus() == GameStatus.ended) return;

    // Hover effects weird on Android
    if (!GetPlatform.isAndroid) handleHover(event, barResponse);

    // Handle only taps for now
    if (event is! FlTapUpEvent) return;

    // Cancel complex moves
    // var controller = Get.find<GameUiController>();
    if (barResponse == null || barResponse.spot == null) {
      stopDivisionMove();
      gameWidget = gameField();
      update();
      return;
    }

    // No meaning in touching second half of divided bar
    if (barResponse.spot!.touchedRodDataIndex != 0) return;

    int touchedHeapIndex = barResponse.spot!.touchedBarGroupIndex;

    // Make division move
    if (heaps[touchedHeapIndex].isEven && !isDivisionMovePerforming() && !isFirstMove) {
      selectedHeapToDivide = touchedHeapIndex;
    }
    else {
      makeMove(touchedHeapIndex);

      if(moveWasVictorious()) {
        if (getCurrentPlayer() == PlayerType.human) {
          confettiController.play();
          Get.snackbar("I'm sorry", "But you won");
        }
        else {
          Get.snackbar("Congratulations", "You're lose 🗿");
        }
        hoveredHeap = -1;
        selectedHeapToDivide = -1;
      }
        customCarouselController.nextPage();
    }

    debugPrint("Heaps: $heaps");
    gameWidget = gameField();
    update();
  }
}