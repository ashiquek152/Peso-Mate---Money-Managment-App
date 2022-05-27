import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/screens/screen_add_transactions/screen_add_transactions.dart';
import 'package:new_app/screens/screen_all_transactions/screen_all_transactions.dart';
import 'package:new_app/screens/screen_home/widgets/top_container.dart';
import 'package:new_app/screens/screen_settings/screen_settings.dart';
import 'package:new_app/widgets/button_style.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/painter_class.dart';
import 'package:new_app/widgets/text_widget.dart';
import 'package:new_app/widgets/transaction_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _MyCustomUIState createState() => _MyCustomUIState();
}

class _MyCustomUIState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  DbHelper dbHelper = DbHelper();
  String? usernameEntered;
  double totalBalance = 0;
  double totalIncome = 0;
  double totalExpense = 0;
  DateTime today = DateTime.now();

  @override
  void initState() {
    getName();
    pageIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scfldWhite,
        appBar: AppBar(
            backgroundColor: amber,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0,
            title: const TextWidget(
                text: "Peso Mate",
                family: 'Swera',
                color: scaffoldbgnew,
                maxsize: 40,
                minsize: 30),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  tooltip: 'Settings',
                  enableFeedback: true,
                  icon: const Icon(
                    CupertinoIcons.gear_alt_fill,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Settingspage(),
                        ));
                  })
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            splashColor: white,
            backgroundColor: amber,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => const AddTransactionPage(),
              ))
                  .whenComplete(() {
                setState(() {});
              });
            },
            child: const Icon(
              Icons.add,
              size: 35.0,
            )),
        body: FutureBuilder<List<TransactionModel>>(
            future: dbHelper.fetchdata(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Unexpected Error'),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                      child: TextWidget(
                    text: "Press + to add",
                    color: scaffoldbgnew,
                    maxsize: 25,
                    minsize: 20,
                  ));
                }
              }
              if (snapshot.data == null) {
                return const Center(child: Text('Nothing found'));
              } else {
                getTotalBalance(snapshot.data!);
              }
              return Stack(children: [
                ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      TopContainer(
                          usernameEntered: usernameEntered,
                          totalBalance: totalBalance,
                          totalIncome: totalIncome,
                          totalExpense: totalExpense),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length < 5
                              ? snapshot.data!.length
                              : 5,
                          itemBuilder: (context, index) {
                            final newList = snapshot.data!.reversed;
                            TransactionModel dataAtindex =
                                newList.elementAt(index);
                            if (dataAtindex.type == 'Income') {
                              return Cards(data: dataAtindex, index: index);
                            } else {
                              return Cards(data: dataAtindex, index: index);
                            }
                          }),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 50,
                              child: ElevatedButton.icon(
                                  icon: const Icon(
                                      Icons.arrow_circle_right_outlined,
                                      color: scfldWhite),
                                  style: buttonStyle(color: amber),
                                  label: const TextWidget(
                                    text: "See all trasactions",
                                    fontWeight: FontWeight.bold,
                                    color: scfldWhite,
                                    maxsize: 16,
                                    minsize: 12,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllTransactionspage(),
                                      )
                                    ).whenComplete(() {
                                      setState(() {});
                                    });
                                  }))),
                      const SizedBox(height: 70)
                    ]),
                CustomPaint(
                  painter: MyPainter(),
                  child: Container(height: 0),
                )
              ]);
            }));
  }

  Future<void> getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    usernameEntered = pref.getString('username');
  }

  getTotalBalance(List<TransactionModel> alldata) async {
    totalBalance = 0;
    totalExpense = 0;
    totalIncome = 0;

    for (TransactionModel data in alldata) {
      if (data.type == 'Income') {
        totalBalance = totalBalance + data.amount;
        totalIncome = totalIncome + data.amount;
      } else {
        totalBalance = totalBalance - data.amount;
        totalExpense = totalExpense + data.amount;
      }
    }
  }
}
