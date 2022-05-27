
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/container_decoration.dart';
import 'package:new_app/widgets/fl_chart/fl_chart_functions.dart';
class TransactionsChart extends StatelessWidget {
final List <TransactionModel> data;
final String chartfor;

   const TransactionsChart({
    Key? key,
     required this.chartfor,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: containerDecoration(),
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15.0),
          child: LineChart(LineChartData(          
            backgroundColor:white,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true)),
                topTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                rightTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: getChartPoints(data, chartfor),
                  isCurved: false,
                  barWidth: 3,
                  color: chartfor=="Income"?green:red,
                ),
              ])),
        ),
    );
  }
}