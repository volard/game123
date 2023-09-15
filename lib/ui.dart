import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game123/components/cancel_floating_button.dart';
import 'package:game123/components/restart_floating_button.dart';
import 'game.dart';

const double barWidth = 45;
const double betweenSpace = 0.2;
const List<Color> heapColors = [Colors.red, Colors.blue, Colors.green];
bool isDoubleStageMovePerforming = false;

List<BarChartGroupData> uiHeaps = [
  makeBarChartGroupData(0),
  makeBarChartGroupData(1),
  makeBarChartGroupData(2),
];

void halveBarChartGroupData(int index) {
  if (index >= heaps.length || index < 0) throw ArgumentError("Provide correct heap index between 0 and ${heaps.length-1}");

  isDoubleStageMovePerforming = true;

  uiHeaps[index] = BarChartGroupData(x: index, groupVertically: true, barRods: [
    BarChartRodData(
      toY: heaps[index].toDouble() / 2,
      color: heapColors[index],
      width: barWidth,
    ),
    BarChartRodData(
      fromY: heaps[index].toDouble() / 2 + betweenSpace,
      toY: heaps[index].toDouble(),
      color: heapColors[index],
      width: barWidth,
    ),
  ],
    showingTooltipIndicators: [0, 1],
  );
  floatingButtons.add(cancelFloatingButton);
}

BarChartGroupData makeBarChartGroupData(int index) {
  if (index >= heaps.length || index < 0) throw ArgumentError("Provide correct heap index between 0 and ${heaps.length-1}");


  return BarChartGroupData(x: index,
      showingTooltipIndicators: [0],
      barRods: [
        BarChartRodData(
          toY: heaps[index].toDouble(),
          color: heapColors[index],
          width: barWidth,
        )
      ]);
}

void cancelComplexMove(){
  var halvedBar = uiHeaps.firstWhere((element) => element.barRods.length > 1);
  uiHeaps[halvedBar.x] = makeBarChartGroupData(halvedBar.x);
  floatingButtons.removeAt(2);
}


var floatingButtons = [
    restartFloatingButton,
    const SizedBox(height: 10,),
];