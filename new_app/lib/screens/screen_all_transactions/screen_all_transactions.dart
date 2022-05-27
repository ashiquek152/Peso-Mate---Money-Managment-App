import 'package:flutter/material.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/functions/filter_by_period.dart';
import 'package:new_app/widgets/button_style.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/common_%20appbar.dart';
import 'package:new_app/widgets/global_variables.dart';
import 'package:new_app/widgets/painter_class.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/text_widget.dart';

int tappedMonth = DateTime.now().month;

class AllTransactionspage extends StatefulWidget {
  const AllTransactionspage({Key? key}) : super(key: key);
  @override
  _AllTransactionspageState createState() => _AllTransactionspageState();
}

class _AllTransactionspageState extends State<AllTransactionspage>
    with SingleTickerProviderStateMixin {
  DbHelper dbHelper = DbHelper();

  final dropdownlist = ['All', 'Today', 'This month', 'This year'];
  var dropdownValue = "All";
  final todayDate = DateTime.now();

  @override
  void initState() {
    pageIndex = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scfldWhite,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarcommon(
            pageHeading: "All Transactions",
          )),
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
                        return const Center(child: Text('Unexpected Error'));
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text("No transactions found"));
                        }
                      }
                      if (snapshot.data == null) {
                        return const Text('Nothing found');
                      } else {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                                child: Column(children: [
                              Column(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                          width: 140,
                                          color: white,
                                          child: DropdownButtonFormField(
                                              decoration: const InputDecoration
                                                  .collapsed(hintText: ''),
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
                                                  dropdownValue =
                                                      value.toString();
                                                });
                                              },
                                              items: dropdownlist.map((e) {
                                                return DropdownMenuItem(
                                                    value: e,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: TextWidget(
                                                          text: e,
                                                          color: scaffoldbgnew,
                                                          maxsize: 15,
                                                          minsize: 11,
                                                        )));
                                              }).toList()))
                                    ])
                              ]),
                              Column(children: [
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  selectMonth(
                                                      monthNum: 1,
                                                      month: "Jan"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 2,
                                                      month: "Feb"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 3,
                                                      month: "Mar"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 4,
                                                      month: "Apr"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 5,
                                                      month: "May"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 6,
                                                      month: "Jun"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 7,
                                                      month: "Jul"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 8,
                                                      month: "Aug"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 9,
                                                      month: "Sep"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 10,
                                                      month: "Oct"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 11,
                                                      month: "Nov"),
                                                  sizedW10,
                                                  selectMonth(
                                                      monthNum: 12,
                                                      month: "Dec"),
                                                ])))),
                                ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      TransactionModel dataAtindex =
                                          snapshot.data![index];
                                     if (dataAtindex.type == 'Income') {
                                        return filterExpenseandIncome(dataAtindex, tappedMonth, dropdownValue, index, todayDate);
                                      }else if (dataAtindex.type == 'Expense') {
                                        return filterExpenseandIncome(dataAtindex, tappedMonth, dropdownValue, index, todayDate);
                                    
                                      }
                                       else {
                                        return const SizedBox();
                                      }
                                    })
                              ])
                            ])));
                      }
                    })
              ]),
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
