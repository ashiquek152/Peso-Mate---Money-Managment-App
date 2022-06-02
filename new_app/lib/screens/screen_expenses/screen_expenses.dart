import 'package:flutter/material.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/functions/filter_by_period.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/common_appbar.dart';
import 'package:new_app/widgets/global_variables.dart';
import 'package:new_app/widgets/months_list.dart';
import 'package:new_app/widgets/painter_class.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/text_widget.dart';

class Expensepage extends StatefulWidget {
  const Expensepage({Key? key}) : super(key: key);

  @override
  _ExpensepageState createState() => _ExpensepageState();
}

class _ExpensepageState extends State<Expensepage>
    with SingleTickerProviderStateMixin {
  DbHelper dbHelper = DbHelper();

  final dropdownlist = ['All', 'Today', 'This month', 'This year'];
  final todayDate = DateTime.now();
  int tappedMonth = DateTime.now().month;
  var dropdownValue = "All";
  Color buttonColor = Colors.amber;
  bool isButtonClicked = false;
  int selectedIndex = -1;

  @override
  void initState() {
    pageIndex = 4;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mqW = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Homepage(),
        ));
      },
      child: Scaffold(
        backgroundColor: scfldWhite,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarcommon(
              pageHeading: "Expenses",
              actionVisiblity: true,
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
                          return const Text("No data found");
                        }
                      }
                      if (snapshot.data == null) {
                        return const Text('Nothing found');
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
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
                                                dropdownValue =
                                                    value.toString();
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
                                  Visibility(
                                    visible: dropdownValue == "This year"
                                        ? true
                                        : false,
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 60,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: const ScrollPhysics(),
                                        child: Row(
                                          children: [
                                            ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: monthsList.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              selectedIndex ==
                                                                      index
                                                                  ? white
                                                                  : amber,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            selectedIndex =
                                                                index;
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
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  sizedH10,
                                ],
                              ),
                              Column(
                                children: [
                                  sizedH10,
                                  ListView.builder(
                                      reverse: true,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        TransactionModel dataAtindex =
                                            snapshot.data![index];
                                        if (dataAtindex.type == 'Expense') {
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
                            ],
                          ),
                        );
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
