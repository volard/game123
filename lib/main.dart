import 'package:game123/ui.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '123 Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

enum Side {
  user,
  opponent
}




class _MyHomePageState extends State<MyHomePage> {

  int touchedIndex = -1;

  var cancelFloatingButton = FloatingActionButton(
    onPressed: () {
      cancelComplexMove();
      // setState(() {});
    },
    child: const Icon(Icons.cancel),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
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
                        child:
                        BarChart(
                          BarChartData(
                              barTouchData: BarTouchData(
                                  enabled: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    fitInsideHorizontally: true,
                                    tooltipRoundedRadius: 20,
                                    getTooltipItem: (BarChartGroupData group,
                                        int groupIndex,
                                        BarChartRodData rod,
                                        int rodIndex,) {
                                      return BarTooltipItem(
                                        rod.toY.round().toString(),
                                        const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                  touchCallback: (event, barResponse){
                                    // Handle only taps for now
                                    if (event is! FlTapUpEvent) return;

                                    // Cancel complex moves
                                    if(barResponse == null || barResponse.spot == null)
                                      {
                                        cancelComplexMove();
                                         setState(() {});
                                         return;
                                      }

                                    int touchedHeapIndex = barResponse.spot!.touchedBarGroupIndex;

                                    // Divide even numbered heap
                                    if (barResponse.spot!.touchedBarGroup.barRods.length == 1 &&
                                        heaps[touchedHeapIndex] % 2 == 0
                                    ){
                                      halveBarChartGroupData(barResponse.spot!.touchedBarGroupIndex);
                                    }
                                    // Increase selected divided heap
                                    else if (barResponse.spot!.touchedBarGroup.barRods.length > 1 &&
                                        barResponse.spot!.touchedRodDataIndex == 1) {
                                      heaps[touchedHeapIndex] = (uiHeaps[barResponse.spot!.touchedBarGroupIndex].barRods[1].toY + 1).toInt();
                                      uiHeaps[0] = makeBarChartGroupData(0);
                                    }
                                    // Choice to move half of selected divided heap
                                    else if (barResponse.spot!.touchedBarGroup.barRods.length > 1 &&
                                        barResponse.spot!.touchedRodDataIndex == 0 &&
                                        isDoubleStageMovePerforming) {

                                    }
                                    // Increase selected heap with next num in queue
                                    else{
                                      makeMove(touchedHeapIndex);
                                      uiHeaps[touchedHeapIndex] = makeBarChartGroupData(touchedHeapIndex);
                                    }
                                    setState(() {});
                                  }

                              ),
                              borderData: FlBorderData(show: false),
                              gridData: const FlGridData(show: false),
                              titlesData: const FlTitlesData(show: false),
                              minY: 0,
                              alignment: BarChartAlignment.spaceEvenly,
                              barGroups: uiHeaps
                          ),
                          swapAnimationDuration: const Duration(milliseconds: 200), // Optional
                          swapAnimationCurve: Curves.easeIn, // Optional
                        ),
                      ),
                    ],
                  )
                ]
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: floatingButtons
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
