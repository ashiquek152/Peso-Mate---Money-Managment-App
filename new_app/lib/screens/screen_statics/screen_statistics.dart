import 'package:flutter/material.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/common_appbar.dart';
import 'package:new_app/widgets/fl_chart/fl_chart.dart';
import 'package:new_app/widgets/global_variables.dart';
import 'package:new_app/widgets/painter_class.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/text_widget.dart';

int statIndex = 1;

bool page = true;
String statDropDownValue = 'Income';

class ScreenStatistics extends StatefulWidget {
  const ScreenStatistics({Key? key}) : super(key: key);

  @override
  State<ScreenStatistics> createState() => _ScreenStatisticsState();
}

class _ScreenStatisticsState extends State<ScreenStatistics> {
  final items = <String>['Income', 'Expense'];
  @override
  void initState() {
    pageIndex=8;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    page = false;
    DbHelper dbHelper = DbHelper();
    return WillPopScope(
      onWillPop: ()async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: scfldWhite,
          appBar: const PreferredSize(
            child: AppBarcommon(
                actionVisiblity: false,
                pageHeading:
                    "statistics"),
            preferredSize: Size.fromHeight(50)),
          body: Stack(
            children: 
              [SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: SizedBox(
                    child: Column(
                      children: [
                        sizedH20,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.26,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color:amber,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: DropdownButton<String>(
                                      iconEnabledColor: Colors.white,
                                      dropdownColor:
                                          amber,
                                      style: const TextStyle(color: Colors.white,fontFamily: fontComforataa),
                                      underline: const Text(''),
                                      borderRadius: BorderRadius.circular(10),
                                      items: items.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      value: statDropDownValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          statDropDownValue = newValue!;
                                        });
                                      }),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        statIndex = 1;
                                      });
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.26,
                                      height:
                                          MediaQuery.of(context).size.height * 0.05,
                                      decoration: BoxDecoration(
                                          color: statIndex == 1
                                              ? scaffoldbgnew
                                              : amber,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                          child: Text(
                                        'This Month',
                                        style: TextStyle(
                                            color: statIndex == 1
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    255, 99, 98, 98)),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        statIndex = 2;
                                      });
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.26,
                                      height:
                                          MediaQuery.of(context).size.height * 0.05,
                                      decoration: BoxDecoration(
                                          color: statIndex == 2
                                               ? scaffoldbgnew
                                              : amber,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                          child: Text(
                                        'This Year',
                                        style: TextStyle(
                                            color: statIndex == 2
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    255, 99, 98, 98)),
                                      )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            sizedH20,
                            FutureBuilder<List<TransactionModel>>(
                                future: dbHelper.fetchdata(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('');
                                  }
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.isEmpty) {
                                      return SizedBox(
                                          width: double.infinity,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                sizedH20,
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.35,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/No data-pana2.png'))),
                                                ),
                                                sizedH20,
                                                const Text(
                                                  'No Records',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 124, 124, 124),
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                          ));
                                    }
                                  }
          
                                  if (snapshot.data == null) {
                                    return const Text('');
                                  }
          
                                  return TransactionsChart(
                                    entiredata: snapshot.data!,
                                    height:
                                        MediaQuery.of(context).size.height * 0.65,
                                  );
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              CustomPaint(
              painter: MyPainter(),
              child: Container(height: 0),
            ),
            ],
          )),
    );
  }
}