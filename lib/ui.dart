import 'package:carousel_slider/carousel_controller.dart';
import 'package:confetti/confetti.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game123/colors.dart';
import 'game.dart';

const double barWidth = 45;
const double betweenSpace = 0.2;
List<Color> heapColors = [
  AppColors.firstHeap,
  AppColors.secondHeap,
  AppColors.thirdHeap,
];

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

CarouselController customCarouselController = CarouselController();
ConfettiController confettiController = ConfettiController(duration: const Duration(seconds: 3),);