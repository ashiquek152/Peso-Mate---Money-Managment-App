
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_app/db_helper/transactions_model.dart';


class ChartWidget extends StatefulWidget {
  List<TransactionModel> entiredata;
  final double height;
  List<FlSpot> dataset = [];
  List<FlSpot> datasetIncome = [];
  List<FlSpot> yearDataSetExpense = [];

  List<FlSpot> yearDatasetExpense = [];

  //DateTime today = DateTime.now();
  ChartWidget({Key? key, required this.entiredata, required this.height})
      : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final List<Color> gradientColorstwo = [
    const Color.fromARGB(255, 230, 35, 35),
    const Color.fromARGB(255, 211, 2, 2),
  ];
  @override
  Widget build(BuildContext context) {
    if (widget.entiredata.length < 2) {
      return const Center(child: Text('Not enough data'));
    } else {
      return Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20)),
          height: widget.height,
          width: 330,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: LineChart(
              LineChartData(
                  titlesData: FlTitlesData(
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                        color: const Color.fromARGB(142, 55, 67, 77), width: 1),
                  ),
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color.fromARGB(79, 55, 67, 77),
                        strokeWidth: 1,
                      );
                    },
                    drawVerticalLine: true,
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: const Color.fromARGB(79, 55, 67, 77),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  lineBarsData: [
                    // LineChartBarData(
                    //     isCurved: true,
                    //     preventCurveOverShooting: true,
                    //     belowBarData: BarAreaData(
                    //         show: true,
                    //         color: statDropDownValue == 'Expense'
                    //             ? const Color.fromARGB(97, 244, 67, 54)
                    //             : const Color.fromARGB(91, 76, 175, 79)),
                    //     gradient: statDropDownValue == 'Expense'
                    //         ? LinearGradient(colors: gradientColorstwo)
                    //         : LinearGradient(colors: gradientColors),
                    //     spots: statDropDownValue == "Expense" && statIndex == 1
                    //         ? getPlotPointsExpense(widget.entiredata)
                    //         : statDropDownValue == "Income" && statIndex == 1
                    //             ? getPlotPoints(widget.entiredata)
                    //             : statDropDownValue == "Income" &&
                    //                     statIndex == 2
                    //                 ? getYearPlotPointsIncome(widget.entiredata)
                    //                 : statDropDownValue == "Expense" &&
                    //                         statIndex == 2
                    //                     ? getYearPlotPointsExpense(
                    //                         widget.entiredata)
                    //                     : getPlotPoints(widget.entiredata),
                    //     barWidth: 5)
                  ]),
            ),
          ));
    }
  }

  List<FlSpot> getPlotPoints(List<TransactionModel> entireData) {
    // final today = DateTime.now();
    ChartWidget chart = ChartWidget(entiredata: widget.entiredata, height: 300);
    List tempDataSetIncome = [];
    final today = DateTime.now();

    for (TransactionModel data in entireData) {
      if (data.dateTime.month == today.month && data.type == "Income") {
        tempDataSetIncome.add(data);
      }
    }

    tempDataSetIncome.sort((a, b) => a.date.day.compareTo(b.date.day));
    for (var i = 0; i < tempDataSetIncome.length; i++) {
      chart.datasetIncome.add(FlSpot(tempDataSetIncome[i].date.day.toDouble(),
          tempDataSetIncome[i].amount.toDouble()));
    }
    return chart.datasetIncome;
  }

  List<FlSpot> getPlotPointsExpense(List<TransactionModel> entireData) {
    final today = DateTime.now();
    ChartWidget chart = ChartWidget(entiredata: widget.entiredata, height: 300);
    List tempDataSet = [];

    for (TransactionModel data in entireData) {
      if (data.dateTime.month == today.month && data.type == "Expense") {
        tempDataSet.add(data);
      }
    }

    tempDataSet.sort((a, b) => a.date.day.compareTo(b.date.day));
    for (var i = 0; i < tempDataSet.length; i++) {
      chart.dataset.add(FlSpot(tempDataSet[i].date.day.toDouble(),
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
    ChartWidget chart = ChartWidget(entiredata: widget.entiredata, height: 300);
    List yearTempDataSetExpense = [];

    for (var i = 1; i <= 12; i++) {
      yearTempDataSetExpense.add(getSumMonth(widget.entiredata, i, "Expense"));
    }

    for (var i = 0; i < yearTempDataSetExpense.length; i++) {
      chart.yearDataSetExpense
          .add(FlSpot(i.toDouble(), yearTempDataSetExpense[i].toDouble()));
    }

    return chart.yearDataSetExpense;
  }

  List<FlSpot> getYearPlotPointsIncome(List<TransactionModel> entireData) {
    ChartWidget chart = ChartWidget(entiredata: widget.entiredata, height: 300);
    List yearTempDataSetExpense = [];

    for (var i = 1; i <= 12; i++) {
      yearTempDataSetExpense.add(getSumMonth(widget.entiredata, i, "Income"));
    }

    for (var i = 0; i < yearTempDataSetExpense.length; i++) {
      chart.yearDataSetExpense
          .add(FlSpot(i.toDouble(), yearTempDataSetExpense[i].toDouble()));
    }

    return chart.yearDataSetExpense;
  }
}