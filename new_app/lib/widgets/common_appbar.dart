import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/screens/screen_expenses/screen_expenses.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/screens/screen_incomes/screen_incomes.dart';
import 'package:new_app/screens/screen_statics/screen_exp_stats.dart';
import 'package:new_app/screens/screen_statics/screen_income_stats.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/global_variables.dart';
import 'package:new_app/widgets/text_widget.dart';

class AppBarcommon extends StatelessWidget {
  const AppBarcommon({
    Key? key,
    required this.actionVisiblity,
    required this.pageHeading,
  }) : super(key: key);

  final String pageHeading;
  final bool actionVisiblity;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: amber,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        title: TextWidget(
          text: pageHeading,
          family: 'Swera',
          color: white,
          maxsize: 20,
          minsize: 16,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Visibility(
            visible: actionVisiblity,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    if (pageIndex == 3) {
                      return const ScreenIncomeStats();
                    } else {
                      return const ScreenExpenseStats();
                    }
                  }));
                },
                icon: const Icon(Icons.auto_graph_outlined),
                tooltip: "Statistics"),
          )
        ],
        leading: IconButton(
            enableFeedback: true,
            icon: const Icon(CupertinoIcons.arrow_left,
                size: 30, color: scfldWhite),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) {
                  switch (pageIndex) {
                    case 5:
                      return const Incomespage();
                    case 6:
                      return const Expensepage();
                    default:
                      return const Homepage();
                  }
                }), (route) => false);
            }));
  }
}
