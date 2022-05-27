import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/functions/filter_by_period.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/widgets/button_style.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/fl_chart/fl_chart.dart';
import 'package:new_app/widgets/fl_chart/fl_chart_functions.dart';
import 'package:new_app/widgets/global_variables.dart';
import 'package:new_app/widgets/painter_class.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/text_widget.dart';

class Incomespage extends StatefulWidget {
  const Incomespage({Key? key}) : super(key: key);

  @override
  _IncomespageState createState() => _IncomespageState();
}

class _IncomespageState extends State<Incomespage>
    with SingleTickerProviderStateMixin {
  DbHelper dbHelper = DbHelper();

  final dropdownlist = ['All', 'Today', 'This month', 'This year'];
  var dropdownValue = "All";
  final todayDate = DateTime.now();
  int tappedMonth = DateTime.now().month;

  @override
  void initState() {
    pageIndex = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scfldWhite,
      appBar: AppBar(
          backgroundColor: amber,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          title: const TextWidget(
            text: "Incomes",
            family: 'Swera',
            color: scaffoldbgnew,
            maxsize: 20,
            minsize: 16,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              enableFeedback: true,
              icon: const Icon(
                CupertinoIcons.arrow_left_circle,
                size: 35,
                color: scfldWhite,
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Homepage()),
                    (route) => false);
              })),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              SizedBox(height: _w / 13),
              FutureBuilder<List<TransactionModel>>(
                  future: dbHelper.fetchdata(),
                  builder: (ccontext, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Unexpected Error'),
                      );
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Text("No data found");
                      }
                    }
                    if (snapshot.data == null) {
                      return const Text('Nothing found');
                    } else {
                      getChartPoints(snapshot.data!,"Income");
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                sizedH10,
                                
                                datasetIncome.length < 2
                                    ? const Center(
                                        child: TextWidget(
                                        text:
                                            "Not enough values to render a chart",
                                        color: Colors.amber,
                                        maxsize: 15,
                                        minsize: 11,
                                      ))
                                    : TransactionsChart(
                                        data: snapshot.data,
                                        chartfor: "Income"),
                                sizedH10,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 140,
                                        color: white,
                                        child: DropdownButtonFormField(
                                          decoration:
                                              const InputDecoration.collapsed(
                                                  hintText: ''),
                                          dropdownColor: amber,
                                          iconSize: 30,
                                          iconEnabledColor: scaffoldbgnew,
                                          hint: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: TextWidget(
                                                text: "All",
                                                color: scaffoldbgnew,
                                                maxsize: 16,
                                                minsize: 12,
                                              )),
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownValue = value.toString();
                                            });
                                          },
                                          items: dropdownlist.map(
                                            (e) {
                                              return DropdownMenuItem(
                                                value: e,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: TextWidget(
                                                      text: e,
                                                      color: scaffoldbgnew,
                                                      maxsize: 15,
                                                      minsize: 11,
                                                    )),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Visibility(
                                  visible: dropdownValue == "This year"
                                      ? true
                                      : false,
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 60,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        //  crossAxisAlignment: ,
                                        children: [
                                          selectMonth(
                                              monthNum: 1, month: "Jan"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 2, month: "Feb"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 3, month: "Mar"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 4, month: "Apr"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 5, month: "May"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 6, month: "Jun"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 7, month: "Jul"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 8, month: "Aug"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 9, month: "Sep"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 10, month: "Oct"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 11, month: "Nov"),
                                          sizedW10,
                                          selectMonth(
                                              monthNum: 12, month: "Dec"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                sizedH10,
                                ListView.builder(
                                    // reverse: true,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      TransactionModel dataAtindex =
                                          snapshot.data![index];
                                      if (dataAtindex.type == 'Income') {
                                        return filterExpenseandIncome(dataAtindex, tappedMonth, dropdownValue, index, todayDate);
                                      } else {
                                        return const SizedBox();
                                      }
                                    }),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),

          // top me rahna
          CustomPaint(
            painter: MyPainter(),
            child: Container(height: 0),
          ),
        ],
      ),
    );
  }

  TextButton selectMonth({required int monthNum, required String month}) {
    return TextButton(
        style: buttonStyle(color: amber, radius: 20),
        onPressed: () {
          setState(() {
            tappedMonth = monthNum;
          });
        },
        child: TextWidget(
          text: month,
          maxsize: 15,
          minsize: 11,
        ));
  }
}
