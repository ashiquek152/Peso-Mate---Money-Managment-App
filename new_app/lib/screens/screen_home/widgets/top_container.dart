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
      height: mqH / 2.6,
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
          sizedH10,
          Container(
            height: mqH / 7.6,
            width: mqW / 1.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: white),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 const TextWidget(
                  text: "Total Balance",
                  color: scaffoldbgnew,
                  fontWeight: FontWeight.bold,
                  maxsize: 30,
                  defaultFont: 22,
                  minsize: 18,
                ),
                TextWidget(
                  text: "₹ ${totalBalance < 0 ? 0 : totalBalance} ",
                  fontWeight: FontWeight.bold,
                  color: scaffoldbgnew,
                  family: "Delius",
                  maxsize: 25,
                  defaultFont: 18,
                  minsize: 12,
                ),
              ],
            ),
          ),
          sizedH10,
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
                  height: mqH / 8.5,
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
                        maxsize: 25,
                        defaultFont:17,
                        minsize: 10,
                      ),
                      TextWidget(
                        text: "$totalIncome",
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        family: "Delius",
                        maxsize: 30,
                        defaultFont:16,
                        minsize: 12,
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
                  height: mqH / 8.5,
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
                         maxsize: 25,
                        defaultFont:17,
                        minsize: 10,
                      ),
                      TextWidget(
                        text: "$totalExpense",
                        fontWeight: FontWeight.bold,
                        color:Colors.red,
                        family: "Delius",
                        maxsize: 30,
                        defaultFont:16,
                        minsize: 12,
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
