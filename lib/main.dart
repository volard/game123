import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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

class _MyHomePageState extends State<MyHomePage> {

  double barWidth = 50;
  final List<int> queue = [3, 1, 2];
  List<int> heaps = [1, 2, 3];


  final randomNumberGenerator = Random();


  @override
  Widget build(BuildContext context) {

    final isUserFirst = randomNumberGenerator.nextBool();
    int touchedIndex = -1;


    updateHeaps(List<int> collection){
      setState(() {
        heaps= collection;
      });
    }


    return Scaffold(

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
                                    BarChartData(
                                      barTouchData: BarTouchData(
                                        enabled: true,
                                        touchTooltipData: BarTouchTooltipData(
                                          // tooltipBgColor: Colors.transparent,
                                          // tooltipPadding: EdgeInsets.zero,
                                          // tooltipMargin: 8,
                                          getTooltipItem: (
                                              BarChartGroupData group,
                                              int groupIndex,
                                              BarChartRodData rod,
                                              int rodIndex,
                                              ) {
                                            return BarTooltipItem(
                                              rod.toY.round().toString(),
                                              const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        ),
                                        touchCallback: (event, barResponse) {
                                          // if (event is FlLongPressEnd && barResponse?.spot != null){
                                          if(event is FlTapUpEvent && barResponse?.spot != null){
                                            debugPrint(event.runtimeType.toString());
                                            debugPrint('${barResponse!.spot!.touchedBarGroup.barRods[0].toY}');
                                            heaps[barResponse.spot!.touchedBarGroup.x] += 3;
                                            updateHeaps(heaps);
                                          }
                                        },
                                      ),
                                      borderData: FlBorderData(show: false),
                                      gridData: const FlGridData(show: false),
                                      titlesData: const FlTitlesData(show: false),
                                      minY: 0,
                                      alignment: BarChartAlignment.spaceEvenly,
                                      barGroups: [
                                        BarChartGroupData(x: 0, barRods: [
                                          BarChartRodData(
                                            toY: heaps[0].toDouble(),
                                            color: Colors.red,
                                            width: barWidth,
                                          ),
                                        ],
                                          showingTooltipIndicators: [0],
                                        ),
                                        BarChartGroupData(x: 1, barRods: [
                                          BarChartRodData(
                                            toY: heaps[1].toDouble(),
                                            color: Colors.blue,
                                            width: barWidth,
                                          ),
                                        ],
                                          showingTooltipIndicators: [0],
                                        ),
                                        BarChartGroupData(x: 2, barRods: [
                                          BarChartRodData(
                                            toY: heaps[2].toDouble(),
                                            color: Colors.green,
                                            width: barWidth,
                                          ),
                                        ],
                                          showingTooltipIndicators: [0],
                                        )
                                      ]
                                    ),
                                    swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                                    swapAnimationCurve: Curves.linear, // Optional
                          ),
                        ),
                    ],
                )
              ]
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{},
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
