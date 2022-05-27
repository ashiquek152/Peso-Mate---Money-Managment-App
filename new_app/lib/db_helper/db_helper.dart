import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';




class DbHelper {
  
  Future<List<TransactionModel>> fetchdata() async {
    final box=Hive.box("MoneyManagement");
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      box.toMap().values.forEach((element) {
        items.add(TransactionModel(
            element['amount'] as int,
            element['category'] as String,
            element['date'] as DateTime,
            element['type'] as String));
      });
      return items;
    }
  }

  Future addtoDB(
    int amount,
    String type,
    DateTime date,
    String category,
  ) async {
    final box=Hive.box("MoneyManagement");

    var value = {
      'amount': amount,
      'date': date,
      'type': type,
      'category': category,
    };
    box.add(value);
  }

  Future deleteData(int index) async {
    final box=Hive.box("MoneyManagement");

    await box.deleteAt(index);
  }

  Future updateDB(int amount, type, selectedDate, category, index) async {
    final box=Hive.box("MoneyManagement");
    var value = {
      'amount': amount,
      'date': selectedDate,
      'type': type,
      'category': category,
    };
    box.putAt(index, value);
    // getChartPoints(, type.toString());
  }

  Future clearDB()async{

    Hive.box('MoneyManagement').clear();
  }

   Future deleteSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
