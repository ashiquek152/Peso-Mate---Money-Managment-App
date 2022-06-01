import 'package:flutter/material.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/fl_chart/fl_chart.dart';
import 'package:new_app/widgets/months_list.dart';
import 'package:new_app/widgets/text_widget.dart';

class ScreenIncomeStats extends StatefulWidget {
  const ScreenIncomeStats({Key? key}) : super(key: key);

  @override
  State<ScreenIncomeStats> createState() => _ScreenIncomeStatsState();
}

class _ScreenIncomeStatsState extends State<ScreenIncomeStats> {
  DbHelper dbHelper = DbHelper();
  final dropdownlist = ['This month', 'This year'];
  var dropdownValue = "This month";
  Color buttonColor = Colors.amber;
  bool isButtonClicked = false;
  int selectedIndex = -1;
  int tappedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder<List<TransactionModel>>(
          future: dbHelper.fetchdata(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Unexpected Error'));
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Text("No data found");
              }
            }
            if (snapshot.data == null) {
              return const Text('Nothing found');
            } else {
              getChartPoints(snapshot.data!);
              return ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 140,
                                color: white,
                                child: DropdownButtonFormField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    dropdownColor: amber,
                                    iconSize: 30,
                                    iconEnabledColor: scaffoldbgnew,
                                    hint: const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: TextWidget(
                                            text: "This month",
                                            color: scaffoldbgnew,
                                            maxsize: 16,
                                            minsize: 12)),
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValue = value.toString();
                                      });
                                    },
                                    items: dropdownlist.map((e) {
                                      return DropdownMenuItem(
                                          value: e,
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: TextWidget(
                                                  text: e,
                                                  color: scaffoldbgnew,
                                                  maxsize: 15,
                                                  minsize: 11)));
                                    }).toList()))
                          ])),
                  Visibility(
                      visible: dropdownValue == "This year" ? true : false,
                      child: Container(
                          color: Colors.transparent,
                          height: 60,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: monthsList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: SizedBox(
                                              height: 30,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:selectedIndex ==index?white:amber),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedIndex = index;
                                                      isButtonClicked = true;
                                                      tappedMonth = index + 1;
                                                    });
                                                  },
                                                  child: Text(
                                                    monthsList[index].toString(),
                                                    style: const TextStyle(color: scaffoldbgnew),
                                                  ))));
                                    })
                              ])))),
                  datasetExpense.isEmpty || datasetExpense.length < 2
                      ? const Text("Not data")
                      : TransactionsChart(data: snapshot.data!),
                ],
              );
            }
          }),
    ));
  }
}
