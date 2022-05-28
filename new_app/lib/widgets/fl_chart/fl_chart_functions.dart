import 'package:fl_chart/fl_chart.dart';
import 'package:new_app/db_helper/transactions_model.dart';

List<FlSpot> dataset = [];
List tempDataset = [];

DateTime todaydate = DateTime.now();

List<FlSpot> getChartPoints(List<TransactionModel> alldata) {
  dataset = [];
  for (TransactionModel data in alldata) {
    if (data.type == "Expense" && data.dateTime.month == todaydate.month) {
      tempDataset.add(data);
    }
  }
  tempDataset.sort((a, b) => a.dateTime.day.compareTo(b.dateTime.day));
  for (var i = 0; i < tempDataset.length; i++) {
    dataset.add(FlSpot(tempDataset[i].dateTime.day.toDouble(),
        tempDataset[i].amount.toDouble()));
  }

  return dataset;
}
