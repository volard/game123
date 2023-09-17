import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game123/game.dart';
import 'package:get/get.dart';
import 'game_ui_controller.dart';

class HomePage extends GetView<GameUiController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameUiController>(
        builder: (controller) =>Scaffold(
          // backgroundColor: Colors.black38,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(80.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: BarChart(
                              controller.barChartData,
                              swapAnimationDuration: const Duration(milliseconds: 250),
                              swapAnimationCurve: Curves.easeIn,)
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(getCurrentNumPending().toString(), textAlign: TextAlign.center,),
                          )
                        ],
                      )
                    ]
                ),
              ),
            ),
          ),
          floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: controller.floatingButtons()
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
    );
  }
}