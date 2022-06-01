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




// 
// 
// 
// 
// 
// 


//  dataSet.isEmpty || dataSet.length < 2
//                     ? Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 40.0,
//                           horizontal: 20.0,
//                         ),
//                         margin: EdgeInsets.all(
//                           12.0,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(
//                             8.0,
//                           ),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 5,
//                               blurRadius: 7,
//                               offset:
//                                   Offset(0, 3), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           "Not Enough Data to render Chart",
//                           style: TextStyle(
//                             fontSize: 20.0,
//                           ),
//                         ),
//                       )
//                     : Container(
//                         height: 400.0,
//                         padding: EdgeInsets.symmetric(
//                           vertical: 40.0,
//                           horizontal: 12.0,
//                         ),
//                         margin: EdgeInsets.all(
//                           12.0,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(8),
//                             topRight: Radius.circular(8),
//                             bottomLeft: Radius.circular(8),
//                             bottomRight: Radius.circular(8),
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 5,
//                               blurRadius: 7,
//                               offset:
//                                   Offset(0, 3), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: LineChart(
//                           LineChartData(
//                             borderData: FlBorderData(
//                               show: false,
//                             ),
//                             lineBarsData: [
//                               LineChartBarData(
//                                 // spots: getPlotPoints(snapshot.data!),
//                                 spots: getPlotPoints(snapshot.data!),
//                                 isCurved: false,
//                                 barWidth: 2.5,
//                                 colors: [
//                                   Static.PrimaryColor,
//                                 ],
//                                 showingIndicators: [200, 200, 90, 10],
//                                 dotData: FlDotData(
//                                   show: true,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                 //