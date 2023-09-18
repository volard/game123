import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game123/components/confetti.dart';
import 'package:game123/components/queue_carousel.dart';
import 'package:game123/game.dart';
import 'package:get/get.dart';
import '../components/pending_number_card.dart';
import '../game_ui_controller.dart';

class HomePage extends GetView<GameUiController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameUiController>(
      builder: (controller) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  confetti(),
                  Expanded(
                      child: BarChart(
                    controller.barChartData,
                    swapAnimationDuration: const Duration(milliseconds: 250),
                    swapAnimationCurve: Curves.easeIn,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                              height: 60, width: 100, child: queueSlider()),
                        ),
                        (isDivisionMovePerforming()
                            ? numberCard(getCurrentNumPending(),
                                shapeBorder: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.yellow,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                )
                        )
                            : const SizedBox.shrink()),
                        Container(margin: const EdgeInsets.only(left: 15), child: Icon(getCurrentPlayer() == PlayerType.computer ? Icons.android : Icons.person)),
                      ],
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: controller
                .floatingButtons()), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
