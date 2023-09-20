import 'package:carousel_slider/carousel_controller.dart';
import 'package:confetti/confetti.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game123/styles/colors.dart';

import '../components/solid_heap.dart';
import '../components/halved_heap.dart';
import 'game_logic.dart';

double barWidth = 45;
double betweenSpace = 0.2;
int hoveredHeap = -1;

var uiHeapsState = [
  UiHeapState(0, AppColors.firstHeap),
  UiHeapState(1, AppColors.secondHeap),
  UiHeapState(2, AppColors.thirdHeap)
];

class UiHeapState{
  UiHeapState(this.index, this.color);

  late int index;
  late Color color;
  bool halved() => index == selectedHeapToDivide;
}

List<BarChartGroupData> getUiHeaps() {
  List<BarChartGroupData> output = [];
  for (var heapState in uiHeapsState) {
    if (!heapState.halved()) {
      output.add(solidHeap(heapState.index));
    }
    else {
      output.add(halvedHeap(heapState.index));
    }
  }
  return output;
}