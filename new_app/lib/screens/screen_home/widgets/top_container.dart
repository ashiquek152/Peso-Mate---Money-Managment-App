import 'package:flutter/material.dart';
import 'package:new_app/screens/screen_expenses/screen_expenses.dart';
import 'package:new_app/screens/screen_incomes/screen_incomes.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/greetings.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/text_widget.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({
    required this.usernameEntered,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
    Key? key,
  }) : super(key: key);

  final String? usernameEntered;
  final double totalBalance;
  final double totalIncome;
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    double mqH = MediaQuery.of(context).size.height;
    double mqW = MediaQuery.of(context).size.width;
    return SizedBox(
      // color: red,
      height: mqH / 2.9,
      child: Column(
        children: [
          sizedH20,
          Row(
            children: [
              sizedW10,
              greetings(),
              SizedBox(
                width: mqW / 50,
              ),
              TextWidget(
                text: "$usernameEntered",
                color: scaffoldbgnew,
                maxsize: 22,
                minsize: 20,
              ),
            ],
          ),
          sizedH20,
          Container(
            height: mqH / 7.6,
            width: mqW / 1.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: white),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(
                  text: "Total Balance",
                  color: scaffoldbgnew,
                  fontWeight: FontWeight.bold,
                  maxsize: 20,
                  minsize: 16,
                ),
                TextWidget(
                  text: "₹ ${totalBalance < 0 ? 0 : totalBalance} ",
                  fontWeight: FontWeight.bold,
                  color: scaffoldbgnew,
                  family: "Delius",
                  maxsize: 30,
                  minsize: 20,
                ),
              ],
            ),
          ),
          sizedH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Incomespage(),
                  ));
                },
                child: Container(
                  height: mqH / 10,
                  width: mqW / 2.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: white),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const TextWidget(
                        text: "Total Income",
                        color: scaffoldbgnew,
                        fontWeight: FontWeight.bold,
                        maxsize: 22,
                        minsize: 20,
                      ),
                      TextWidget(
                        text: "₹ $totalIncome",
                        fontWeight: FontWeight.bold,
                        color: scaffoldbgnew,
                        family: "Delius",
                          maxsize: 30,
                        minsize: 18,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Expensepage(),
                  ));
                },
                child: Container(
                  height: mqH / 10,
                  width: mqW / 2.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: white),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const TextWidget(
                        text: "Total Expense",
                        color: scaffoldbgnew,
                        fontWeight: FontWeight.bold,
                        maxsize: 22,
                        minsize: 20,
                      ),
                      TextWidget(
                        text: "₹ $totalExpense",
                        fontWeight: FontWeight.bold,
                        color: scaffoldbgnew,
                        family: "Delius",
                        maxsize: 30,
                        minsize: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
