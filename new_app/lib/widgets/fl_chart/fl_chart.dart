import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/container_decoration.dart';
import 'package:new_app/widgets/global_variables.dart';

class TransactionsChart extends StatefulWidget {
  final List<TransactionModel> data;
  final String chartfor;

  const TransactionsChart({
    Key? key,
    required this.chartfor,
    required this.data,
  }) : super(key: key);

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
                    return FlLine(color: Colors.blue, strokeWidth: 0.5);
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(color: Colors.blue, strokeWidth: 0.5);
                  }),
              backgroundColor: white,
              titlesData: FlTitlesData(
                bottomTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: true)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                  border: Border.all(color: Colors.blue, width: 3), show: true),
              lineBarsData: [
                LineChartBarData(
                  preventCurveOverShooting: true,
                  spots: getChartPoints(widget.data),
                  isCurved: true,
                  gradient: LinearGradient(colors: lineColorExp),
                  barWidth: 5,
                  color: red,
                  belowBarData: BarAreaData(show: true),
                )
              ])),
        ));
  }

  List<FlSpot> datasetIncome = [];
  List<FlSpot> datasetExpense = [];
  List<FlSpot> datasetNothing = [];
  List tempDataset = [];

  DateTime todaydate = DateTime.now();

  List<FlSpot> getChartPoints(List<TransactionModel> alldata) {
    datasetExpense = [];
    datasetIncome = [];

    if (pageIndex == 4) {
      for (TransactionModel data in alldata) {
        if (data.type == "Expense" && data.dateTime.month == todaydate.month) {
          tempDataset.add(data);
        }
      }

      tempDataset.sort((a, b) => a.dateTime.day.compareTo(b.dateTime.day));
      for (var i = 0; i < tempDataset.length; i++) {
        datasetExpense.add(FlSpot(tempDataset[i].dateTime.day.toDouble(),
            tempDataset[i].amount.toDouble()));
      }
      return datasetExpense;
    } else if (pageIndex == 3) {
      for (var data in alldata) {
        if (data.type == "Income" && data.dateTime.month == todaydate.month) {
          tempDataset.add(data);
        }
      }
      tempDataset.sort((a, b) => a.dateTime.day.compareTo(b.dateTime.day));
      for (var i = 0; i < tempDataset.length; i++) {
        datasetIncome.add(FlSpot(tempDataset[i].dateTime.day.toDouble(),
            tempDataset[i].amount.toDouble()));
      }
      return datasetIncome;
    }
    return datasetNothing;
  }
}
