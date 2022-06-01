import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/container_decoration.dart';

List<FlSpot> datasetIncome = [];
List<FlSpot> datasetExpense = [];
List<FlSpot> datasetNothing = [];
List tempDataset = [];

class TransactionsChart extends StatefulWidget {
  final List<TransactionModel> data;
  final int? selectedTab;
  const TransactionsChart(
      {Key? key, required this.data, required this.selectedTab})
      : super(key: key);

  @override
  State<TransactionsChart> createState() => _TransactionsChartState();
}

class _TransactionsChartState extends State<TransactionsChart> {
  List<Color> lineColorExp = [amber, red];
  List<Color> lineColorInc = [amber, green];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: containerDecoration(),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.all(15.0),
          child: LineChart(LineChartData(
              // maxX:3,
              minX: 1,
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
                  spots: getChartPoints(widget.data, widget.selectedTab),
                  isCurved: true,
                  gradient: LinearGradient(colors: lineColorExp),
                  barWidth: 5,
                  color: red,
                  belowBarData: BarAreaData(show: true),
                )
              ])),
        ));
  }
}

DateTime todaydate = DateTime.now();

List<FlSpot> getChartPoints(List<TransactionModel> alldata, selectedTab) {
  datasetExpense = [];
  datasetIncome = [];

  if (selectedTab == 2) {
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
  } else if (selectedTab == 1) {
    for (TransactionModel data in alldata) {
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
