import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import '../styles/colors.dart';
import '../game/game_logic.dart';
import '../game/game_ui.dart';

BarChartGroupData halvedHeap(int index) {
  if (index >= heaps.length || index < 0) {
    throw ArgumentError(
        "Provide correct heap index between 0 and ${heaps.length - 1}");
  }

  // Define platform specific style
  Color barColor;
  BorderSide barBorder = const BorderSide(width: 0);
  if (GetPlatform.isAndroid){
    barColor = Colors.transparent;
    barBorder = const BorderSide(color: Colors.yellow, width: 2);
  }
  else{
    barColor = hoveredHeap != -1 ? Colors.transparent : uiHeapsState[index].color;
  }

  return BarChartGroupData(x: index, groupVertically: true, barRods: [
    BarChartRodData(
      toY: hoveredHeap == index
          ? heaps[index] +
          getCurrentNumPending(ignoreDivisionMove: true).toDouble()
          : getCurrentNumPending().toDouble(),
      color: hoveredHeap == index ? AppColors.hoveredHeap : uiHeapsState[index].color,
      width: barWidth,
    ),
    BarChartRodData(
      borderSide: barBorder,
      fromY: heaps[index].toDouble() / 2 + betweenSpace,
      toY: heaps[index].toDouble(),
      color: barColor,
      width: barWidth,
    ),
  ],
    showingTooltipIndicators: [0],
  );
}