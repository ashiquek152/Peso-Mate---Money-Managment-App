

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/screens/screen_statics/screen_statistics.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/container_decoration.dart';

class TransactionsChart extends StatefulWidget {
  final List<TransactionModel> entiredata;
  final double height;
  final List<FlSpot> dataset = [];
  final List<FlSpot> datasetIncome = [];
  final List<FlSpot> yearDataSetExpense = [];

  final List<FlSpot> yearDatasetExpense = [];

  //DateTime today = DateTime.now();
  TransactionsChart({Key? key, required this.entiredata, required this.height})
      : super(key: key);

  @override
  State<TransactionsChart> createState() => _TransactionsChartState();
}

class _TransactionsChartState extends State<TransactionsChart> {
  List<Color> lineColorExp = [amber, red];
  List<Color> lineColorInc = [amber, green];
  @override
  Widget build(BuildContext context) {
    if (widget.entiredata.length < 2) {
      return const Center(child: Text('Not enough data'));
    } else {
      return Container(
          decoration: containerDecoration(),
           height: MediaQuery.of(context).size.height * 0.7,
          // width: MediaQuery.of(context).size.width * 0.2,
          padding: const EdgeInsets.all(15.0),
          child: LineChart(LineChartData(
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
                        isCurved: true,
                        preventCurveOverShooting: true,
                        belowBarData: BarAreaData(
                            show: true,
                            color: statDropDownValue == 'Expense'
                                ? const Color.fromARGB(97, 244, 67, 54)
                                : const Color.fromARGB(91, 76, 175, 79)),
                        gradient: statDropDownValue == 'Expense'
                            ? LinearGradient(colors: lineColorExp)
                            : LinearGradient(colors: lineColorInc),
                        spots: statDropDownValue == "Expense" && statIndex == 1
                            ? getPlotPointsExpense(widget.entiredata)
                            : statDropDownValue == "Income" && statIndex == 1
                                ? getPlotPoints(widget.entiredata)
                                : statDropDownValue == "Income" &&
                                        statIndex == 2
                                    ? getYearPlotPointsIncome(widget.entiredata)
                                    : statDropDownValue == "Expense" &&
                                            statIndex == 2
                                        ? getYearPlotPointsExpense(
                                            widget.entiredata)
                                        : getPlotPoints(widget.entiredata),
                        barWidth: 5)
                  ]),
            ),
          );
    }
  }

  List<FlSpot> getPlotPoints(List<TransactionModel> entireData) {
    // final today = DateTime.now();
    TransactionsChart chart = TransactionsChart(entiredata: widget.entiredata, height: 300);
    List tempDataSetIncome = [];
    final today = DateTime.now();

    for (TransactionModel data in entireData) {
      if (data.dateTime.month == today.month && data.type == "Income") {
        tempDataSetIncome.add(data);
      }
    }

    tempDataSetIncome.sort((a, b) => a.dateTime.day.compareTo(b.dateTime.day));
    for (var i = 0; i < tempDataSetIncome.length; i++) {
      chart.datasetIncome.add(FlSpot(tempDataSetIncome[i].dateTime.day.toDouble(),
          tempDataSetIncome[i].amount.toDouble()));
    }
    return chart.datasetIncome;
  }

  List<FlSpot> getPlotPointsExpense(List<TransactionModel> entireData) {
    final today = DateTime.now();
    TransactionsChart chart = TransactionsChart(entiredata: widget.entiredata, height: 300);
    List tempDataSet = [];

    for (TransactionModel data in entireData) {
      if (data.dateTime.month == today.month && data.type == "Expense") {
        tempDataSet.add(data);
      }
    }

    tempDataSet.sort((a, b) => a.dateTime.day.compareTo(b.dateTime.day));
    for (var i = 0; i < tempDataSet.length; i++) {
      chart.dataset.add(FlSpot(tempDataSet[i].dateTime.day.toDouble(),
          tempDataSet[i].amount.toDouble()));
    }

    return chart.dataset;
  }

  int getSumMonth(
      List<TransactionModel> entireData, int month, String transactionType) {
    int sum = 0;
    for (TransactionModel transaction in entireData) {
      if (transaction.dateTime.month == month &&
          transaction.type == transactionType) {
        sum += transaction.amount;
      }
    }
    return sum;
  }

  List<FlSpot> getYearPlotPointsExpense(List<TransactionModel> entireData) {
    TransactionsChart chart = TransactionsChart(entiredata: widget.entiredata, height: 300);
    List yearTempDataSetExpense = [];

    for (var i = 1; i <= 12; i++) {
      yearTempDataSetExpense.add(getSumMonth(widget.entiredata, i, "Expense"));
    }

    for (var i = 0; i < yearTempDataSetExpense.length; i++) {
      chart.yearDataSetExpense
          .add(FlSpot(i+1.toDouble(), yearTempDataSetExpense[i].toDouble()));
    }

    return chart.yearDataSetExpense;
  }

  List<FlSpot> getYearPlotPointsIncome(List<TransactionModel> entireData) {
    TransactionsChart chart = TransactionsChart(entiredata: widget.entiredata, height: 300);
    List yearTempDataSetExpense = [];

    for (var i = 1; i <= 12; i++) {
      yearTempDataSetExpense.add(getSumMonth(widget.entiredata, i, "Income"));
    }

    for (var i = 0; i <yearTempDataSetExpense.length; i++) {
      chart.yearDataSetExpense
          .add(FlSpot(i+1.toDouble(), yearTempDataSetExpense[i].toDouble()));
    }

    return chart.yearDataSetExpense;
  }
}