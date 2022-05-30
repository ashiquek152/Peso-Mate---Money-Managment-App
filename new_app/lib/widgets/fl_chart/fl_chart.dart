import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/container_decoration.dart';
import 'package:new_app/widgets/fl_chart/fl_chart_functions.dart';

class TransactionsChart extends StatefulWidget {
  final List<TransactionModel> data;
  final String chartfor;
  final String dropDownValue;

  const TransactionsChart(
      {Key? key,
      required this.chartfor,
      required this.data,
      required this.dropDownValue})
      : super(key: key);

  @override
  State<TransactionsChart> createState() => _TransactionsChartState();
}

class _TransactionsChartState extends State<TransactionsChart> {
  List<Color> lineColorExp = [red, amber];

  List<Color> lineColorInc = [green, amber];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: containerDecoration(),
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15.0),
          child: LineChart(LineChartData(
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.blue,
                    strokeWidth: 0.5,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.blue,
                    strokeWidth: 0.5,
                  );
                },
              ),
              backgroundColor: white,
              titlesData: FlTitlesData(
                bottomTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: true)),
                topTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                  border: Border.all(color: Colors.blue, width: 3), show: true),
              lineBarsData: [
                LineChartBarData(
                  preventCurveOverShooting: true,
                  spots: getChartPoints(widget.data, widget.chartfor, widget.dropDownValue),
                  isCurved: true,
                  // gradient:LinearGradient(colors: lineColorExp),
                  barWidth: 5,
                  color: red,
                  belowBarData: BarAreaData(
                    show: true,

                    // cutOffY: 1.5,
                    // gradient:Gradient(colors:  [Colors.lightBlue.withOpacity(0.5)]),
                    // applyCutOffY: true,
                  ),
                ),
              ])),
        ));
  }
}
