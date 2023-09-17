import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game123/ui.dart';
import 'package:get/get.dart';
import 'colors.dart';
import 'components/floating_buttons.dart';
import 'game.dart';

class GameUiController extends GetxController {

  BarChartGroupData getSolidChartGroupData(int index) {
    if (index >= heaps.length || index < 0) {
      throw ArgumentError(
          "Provide correct heap index between 0 and ${heaps.length - 1}");
    }

    var data = [
      BarChartRodStackItem(
        0,
        heaps[index] / 2,
        heapColors[index],
        const BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
      BarChartRodStackItem(
        heaps[index] / 2,
        heaps[index].toDouble(),
        heapColors[index],
        const BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
    ];

    return BarChartGroupData(x: index,
        showingTooltipIndicators: [0],
        barRods: [
          BarChartRodData(
              toY: hoveredHeap == index &&
                  (heaps[index].isOdd || isDivisionMovePerforming())
                  ? heaps[index].toDouble() +
                  getCurrentNumPending()
                  : heaps[index].toDouble(),
              color: hoveredHeap == index &&
                  (heaps[index].isOdd || isDivisionMovePerforming()) ? Colors
                  .yellow : heapColors[index],
              width: barWidth,
              rodStackItems: hoveredHeap == index && heaps[index].isEven &&
                  !isDivisionMovePerforming() ? data : []
          ),
        ]
    );
  }

  BarChartGroupData getSplitBarChartGroupData(int index) {
    if (index >= heaps.length || index < 0) {
      throw ArgumentError(
          "Provide correct heap index between 0 and ${heaps.length - 1}");
    }

    return BarChartGroupData(x: index, groupVertically: true, barRods: [
      BarChartRodData(
        toY: hoveredHeap == index
            ? heaps[index] +
            getCurrentNumPending(ignoreDivisionMove: true).toDouble()
            : getCurrentNumPending().toDouble(),
        color: hoveredHeap == index ? AppColors.hoveredHeap : heapColors[index],
        width: barWidth,
      ),
      BarChartRodData(

        fromY: heaps[index].toDouble() / 2 + betweenSpace,
        toY: heaps[index].toDouble(),
        color: hoveredHeap != -1 ? Colors.transparent : heapColors[index],
        width: barWidth,
      ),
    ],
      showingTooltipIndicators: [0],
    );
  }

  BarChartData getBarChartData() =>
      BarChartData(
          barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                fitInsideHorizontally: true,
                tooltipRoundedRadius: 20,
                getTooltipItem: tooltipBar,
              ),
              touchCallback: handleTouch
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          minY: 0,
          maxY: heaps.reduce(max).toDouble() + 5,
          alignment: BarChartAlignment.spaceEvenly,
          barGroups: getUiHeaps()
      );

  late var barChartData = getBarChartData();

  List<BarChartGroupData> getUiHeaps() {
    List<BarChartGroupData> output = [];
    for (var heapState in uiState) {
      if (!heapState.halved()) {
        output.add(getSolidChartGroupData(heapState.index));
      }
      else {
        output.add(getSplitBarChartGroupData(heapState.index));
      }
    }
    return output;
  }

  List<Widget> floatingButtons() {
    var buttons = [
      restartFloatingButton,
      const SizedBox(height: 10,),
      changeThemeFloatingButton,
      const SizedBox(height: 10,),
    ];

    if (isDivisionMovePerforming()) buttons.add(cancelFloatingButton);
    return buttons;
  }

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
    barChartData = getBarChartData();
    update();
  }

  void handleTouch(event, BarTouchResponse? barResponse) {
    debugPrint(event.toString());
    debugPrint("Hovered heap id: ${hoveredHeap.toString()}");

    if (getGameStatus() == GameStatus.ended) return;

    handleHover(event, barResponse);

    // Handle only taps for now
    if (event is! FlTapUpEvent) return;

    // Cancel complex moves
    // var controller = Get.find<GameUiController>();
    if (barResponse == null || barResponse.spot == null) {
      stopDivisionMove();
      barChartData = getBarChartData();
      return;
    }

    // No meaning in touching second half of divided bar
    if (barResponse.spot!.touchedRodDataIndex != 0) return;

    int touchedHeapIndex = barResponse.spot!.touchedBarGroupIndex;
    debugPrint("Touched heap id: $touchedHeapIndex");

    if (heaps[touchedHeapIndex].isEven && !isDivisionMovePerforming()) {
      selectedHeapToDivide = touchedHeapIndex;
    }
    else {
      makeMove(touchedHeapIndex);
      if(wasMoveVictorious()){
        // todo confetti animation
      } else{
        customCarouselController.nextPage();
      }

    }


    debugPrint("Heaps: $heaps");
    barChartData = getBarChartData();
    update();
  }

}