import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../game/game_logic.dart';
import '../controllers/game_ui_controller.dart';
import '../game/game_ui.dart';

BarChartData gameField() =>
    BarChartData(
        barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              fitInsideHorizontally: true,
              tooltipRoundedRadius: 20,
              getTooltipItem: tooltipBar,
            ),
            touchCallback: Get.find<GameUiController>().handleTouch
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        minY: 0,
        maxY: heaps.reduce(max).toDouble() + 5,
        alignment: BarChartAlignment.spaceEvenly,
        barGroups: getUiHeaps()
    );


BarTooltipItem tooltipBar(BarChartGroupData group,
    int groupIndex,
    BarChartRodData rod,
    int rodIndex) {
  return BarTooltipItem(
    rod.toY.round().toString(),
    const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}