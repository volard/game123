import 'dart:math';
import 'dart:math';
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


  final randomNumberGenerator = Random();


  @override
  Widget build(BuildContext context) {

    final isUserFirst = randomNumberGenerator.nextBool();
    int touchedIndex = -1;

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
                                        enabled: false,
                                        touchTooltipData: BarTouchTooltipData(
                                          tooltipBgColor: Colors.transparent,
                                          tooltipPadding: EdgeInsets.zero,
                                          tooltipMargin: 8,
                                          getTooltipItem: (
                                              BarChartGroupData group,
                                              int groupIndex,
                                              BarChartRodData rod,
                                              int rodIndex,
                                              ) {
                                            return BarTooltipItem(
                                              rod.toY.round().toString(),
                                              const TextStyle(
                                                color: Colors.yellow,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        ),
                                      ),


                                      borderData: FlBorderData(show: false),
                                      gridData: const FlGridData(show: false),
                                      titlesData: const FlTitlesData(show: false),

                                      minY: 0,

                                      alignment: BarChartAlignment.spaceEvenly,

                                      barGroups: [
                                        BarChartGroupData(x: 10, barRods: [
                                          BarChartRodData(

                                            toY: 1,
                                            color: Colors.red,
                                            width: barWidth,
                                          ),
                                        ],
                                          showingTooltipIndicators: [0],
                                        ),

                                        BarChartGroupData(x: 10, barRods: [
                                          BarChartRodData(
                                            toY: 26,
                                            color: Colors.blue,
                                            width: barWidth,
                                          ),
                                        ],
                                          showingTooltipIndicators: [0],
                                        ),

                                        BarChartGroupData(x: 10, barRods: [
                                          BarChartRodData(
                                            toY: 14,
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
