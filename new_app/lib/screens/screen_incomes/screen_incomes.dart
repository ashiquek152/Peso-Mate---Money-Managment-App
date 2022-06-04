import 'package:flutter/material.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/functions/filter_by_period.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/screens/screen_statics/screen_statistics.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/common_appbar.dart';
import 'package:new_app/widgets/global_variables.dart';
import 'package:new_app/widgets/months_list.dart';
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
  final todayDate = DateTime.now();
  int tappedMonth = DateTime.now().month;
  var dropdownValue = "All";
  Color buttonColor = Colors.amber;
  bool isButtonClicked = false;
  int selectedIndex = -1;
  bool noTransaction = true;

  @override
  void initState() {
    pageIndex = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double mqH = MediaQuery.of(context).size.height;
    double mqW = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
		  pageIndex=1;
        return await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
            (route) => false);
      },
      child: Scaffold(
        backgroundColor: scfldWhite,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBarcommon(
              pageHeading: "Incomes",
              actionVisiblity: noTransaction,
            )),
        body: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                SizedBox(height: mqW / 13),
                FutureBuilder<List<TransactionModel>>(
                    future: dbHelper.fetchdata(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('Unexpected Error'));
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          noTransaction = false;
                          return const Center(
                              child: TextWidget(
                            text: "No transactions found",
                            minsize: 25,
                            family: "Delius",
                            maxsize: 40,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ));
                        }
                      }
                      if (snapshot.data == null) {
                        return const Text('Nothing found');
                      } else {
                        return SingleChildScrollView(
                            child: Column(children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          padding: EdgeInsets.only(left: 10),
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
                                                padding: const EdgeInsets.only(
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
									   InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const ScreenStatistics();
                                        }));
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.26,
                                      height:
                                          MediaQuery.of(context).size.height * 0.05,
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.circular(20)),
                                      child:  const Center(
                                          child: Text(
                                        'Statistics',
                                        style: TextStyle(
											fontFamily: fontComforataa,
											// fontWeight: FontWeight.bold,
                                            color: scaffoldbgnew),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                                visible:
                                    dropdownValue == "This year" ? true : false,
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
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  selectedIndex ==
                                                                          index
                                                                      ? white
                                                                      : amber),
                                                      onPressed: () {
                                                        setState(() {
                                                          selectedIndex = index;
                                                          isButtonClicked =
                                                              true;
                                                          tappedMonth =
                                                              index + 1;
                                                        });
                                                      },
                                                      child: Text(
                                                        monthsList[index]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                scaffoldbgnew),
                                                      )),
                                                );
                                              }),
                                        ])))),
                            sizedH10,
                          ]),
                          Column(
                            children: [
                              sizedH10,
                              ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    TransactionModel dataAtindex =
                                        snapshot.data![index];
                                    if (dataAtindex.type == 'Income') {
                                      return filterExpenseandIncome(
                                        dataAtindex,
                                        tappedMonth,
                                        dropdownValue,
                                        index,
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
                            ],
                          )
                        ]));
                      }
                    }),
              ],
            ),
            CustomPaint(
              painter: MyPainter(),
              child: Container(height: 0),
            ),
          ],
        ),
      ),
    );
  }
}
