import 'package:fl_chart/fl_chart.dart';
import 'package:new_app/db_helper/transactions_model.dart';

List<FlSpot> datasetIncome = [];
List<FlSpot> datasetExpense = [];
List<FlSpot> datasetNothing = [];
List tempDataset = [];
List tempDataset2 = [];


DateTime todaydate = DateTime.now();

List<FlSpot> getChartPoints(List<TransactionModel> alldata, String chartof) {
  datasetExpense = [];
  datasetIncome = [];
   

  if (chartof == "Expense") {
    for (TransactionModel data in alldata) {
      if (data.type == "Expense" &&
          data.dateTime.month == todaydate.month) {
        tempDataset.add(data);
          }      
    }

    tempDataset.sort((a, b) => a.dateTime.day.compareTo(b.dateTime.day));
    for (var i = 0; i < tempDataset.length ; i++) {
      datasetExpense.add(FlSpot(tempDataset[i].dateTime.day.toDouble(), tempDataset[i].amount.toDouble()));
      
    }

    return datasetExpense;
  } else if (chartof == "Income") {
    for (var data in alldata) {
      if (data.type == "Income" &&
          data.dateTime.month == todaydate.month) {
        tempDataset2.add(data);
      }
    }tempDataset2.sort((a, b) => a.dateTime.day.compareTo(b.dateTime.day));
    for (var i = 0; i < tempDataset2.length ; i++) {
      datasetIncome.add(FlSpot(tempDataset2[i].dateTime.day.toDouble(), tempDataset2[i].amount.toDouble()));
      
    }
    return datasetIncome;
  }
  return datasetNothing;
}
