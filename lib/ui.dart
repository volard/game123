import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'game.dart';

const double barWidth = 45;
const double betweenSpace = 0.2;
const List<Color> heapColors = [Colors.red, Colors.blue, Colors.green];

class HeapState{
  HeapState(this.index);

  late int index;
  bool halved() => index == selectedHeapToDivide;
}

int hoveredHeap = -1;

var uiState = [HeapState(0), HeapState(1), HeapState(2)];

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