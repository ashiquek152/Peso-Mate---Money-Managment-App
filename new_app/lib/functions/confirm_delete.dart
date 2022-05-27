import 'package:flutter/material.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/screens/screen_all_transactions/screen_all_transactions.dart';
import 'package:new_app/screens/screen_expenses/screen_expenses.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/screens/screen_incomes/screen_incomes.dart';
import 'package:new_app/widgets/button_style.dart';
import 'package:new_app/widgets/colors.dart';

Future confirmDelete(index, context) async {
  DbHelper dbHelper = DbHelper();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: scaffoldbgnew,
        title: const Text(
          "Confirm",
          style: TextStyle(color: scfldWhite),
        ),
        content: const Text(
          "Are you sure, you wish to delete this item ?",
        ),
        actions: [
          TextButton(
              style: buttonStyle(color: amber),
              onPressed: () {
                dbHelper.deleteData(index);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) {
                  switch (pageIndex) {
                    case 1:
                      return const Homepage();
                    case 2:
                      return const AllTransactionspage();
                    case 3:
                      return const Incomespage();
                    case 4:
                      return const Expensepage();
                    default:
                      return const Homepage();
                  }
                }), (route) => false);
              },
              child: const Text("DELETE")),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "CANCEL",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}