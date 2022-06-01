import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/screens/screen_statics/screen_exp_stats.dart';
import 'package:new_app/screens/screen_statics/screen_income_stats.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/text_widget.dart';

class ScreenStatistics extends StatefulWidget {
  const ScreenStatistics({Key? key}) : super(key: key);

  @override
  State<ScreenStatistics> createState() => _ScreenStatisticsState();
}

class _ScreenStatisticsState extends State<ScreenStatistics> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: scfldWhite,
        appBar: AppBar(
          centerTitle: true,
         title: const TextWidget(
          text: "Statistics",
          family: 'Swera',
          color: white,
          maxsize: 20,
          minsize: 16,
        ),
          backgroundColor: amber,
          leading: IconButton(
              enableFeedback: true,
              icon: const Icon(CupertinoIcons.arrow_left,
                  size: 30, color: scfldWhite),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          elevation: 0,
          toolbarHeight: 50,
          bottom: TabBar(
            indicatorColor: amber,
            tabs: const [
              TextWidget(
                  text: "Income", maxsize: 25, minsize: 10, defaultFont: 22),
              TextWidget(
                  text: "Expense", maxsize: 25, minsize: 10, defaultFont: 22),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ScreenIncomeStats(),
            ScreenExpenseStats(),
          ],
        ),
      ),
    );
  }
}
