import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../game/game_logic.dart';
import '../game/game_ui.dart';

BarChartGroupData solidHeap(int index) {
  if (index >= heaps.length || index < 0) {
    throw ArgumentError(
        "Provide correct heap index between 0 and ${heaps.length - 1}");
  }

  List<BarChartRodStackItem>? rodItems;

  double toY = heaps[index].toDouble();
  Color groupColor = uiHeapsState[index].color;

  // recalculate properties on hover
  if (hoveredHeap == index) {
    // calculate to Y
    if (isFirstMove || heaps[index].isOdd || isDivisionMovePerforming()) {
      toY = heaps[index].toDouble() + getCurrentNumPending();
      groupColor = Colors.yellow;
    }

    if (heaps[index].isEven && !isDivisionMovePerforming() && !isFirstMove) {
      rodItems = [
        BarChartRodStackItem(
          0,
          heaps[index] / 2,
          uiHeapsState[index].color,
          const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        BarChartRodStackItem(
          heaps[index] / 2,
          heaps[index].toDouble(),
          uiHeapsState[index].color,
          const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ];
    }
  }

  return BarChartGroupData(x: index, showingTooltipIndicators: [
    0
  ], barRods: [
    BarChartRodData(
        toY: toY, color: groupColor, width: barWidth, rodStackItems: rodItems),
  ]);
}
