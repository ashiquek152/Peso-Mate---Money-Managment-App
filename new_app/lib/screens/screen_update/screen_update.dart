import 'package:flutter/material.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/screens/screen_all_transactions/screen_all_transactions.dart';
import 'package:new_app/screens/screen_expenses/screen_expenses.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/screens/screen_incomes/screen_incomes.dart';
import 'package:new_app/widgets/button_style.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/common_%20appbar.dart';
import 'package:new_app/widgets/container_decoration.dart';
import 'package:new_app/widgets/global_variables.dart';
import 'package:new_app/widgets/months_list.dart';
import 'package:new_app/widgets/painter_class.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/snackbar.dart';
import 'package:new_app/widgets/text_widget.dart';
import 'package:new_app/widgets/textfield_border.dart';

class Updatescreen extends StatefulWidget {
  const Updatescreen({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final TransactionModel data;
  final int index;

  @override
  State<Updatescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Updatescreen> {
  int? amount;
  String category = '';
  String type = 'Income';
  DateTime selectedDate = DateTime.now();
  int? index;

  GlobalKey<FormState> formkey = GlobalKey();

  DbHelper dbHelper = DbHelper();

  final amountController = TextEditingController();
  final catController = TextEditingController();

  @override
  void initState() {
    index = widget.index;
    amount = widget.data.amount;
    type = widget.data.type;
    category = widget.data.category;
    selectedDate = widget.data.dateTime;
    amountController.text = widget.data.amount.toString();
    catController.text = widget.data.category.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: scfldWhite,
        appBar: PreferredSize(
            child: AppBarcommon(
                pageHeading:
                    type == "Expense" ? "Edit Expense" : "Edit Income"),
            preferredSize: const Size.fromHeight(50)),
        body: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(15),
                  width: size.width * .9,
                  height: size.width * 1.1,
                  decoration: containerDecoration(),
                  child: Form(
                    key: formkey,
                    child: ListView(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              sizedH40,
                              TextFormField(
                                  controller: amountController,
                                  validator: (value) {
                                    return (value == null || value.isEmpty)
                                        ? 'Please enter an amount '
                                        : null;
                                  },
                                  maxLength: 15,
                                  decoration: textFiledDecorations("Amount...",
                                      Icons.account_balance_wallet_outlined),
                                  style: const TextStyle(color: scaffoldbgnew),
                                  onChanged: (val) {
                                    amount = int.parse(val);
                                  },
                                  keyboardType: TextInputType.number),
                              TextFormField(
                                  controller: catController,
                                  validator: (value) {
                                    return (value == null || value.isEmpty)
                                        ? 'Please enter a category '
                                        : null;
                                  },
                                  maxLength: 15,
                                  decoration: textFiledDecorations(
                                      "Category...", Icons.category_outlined),
                                  style: const TextStyle(
                                    color: scaffoldbgnew,
                                  ),
                                  onChanged: (val) {
                                    category = val;
                                  }),
                              sizedH20,
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                selectDate(context);
                              },
                              child: Container(
                                  color: scfldWhite,
                                  height: 50,
                                  width: 200,
                                  child: Center(
                                    child: TextWidget(
                                      text:
                                          "${selectedDate.day} ${monthsList[selectedDate.month - 1]}",
                                      color: scaffoldbgnew,
                                      fontWeight: FontWeight.bold,
                                      maxsize: 18,
                                      minsize: 14,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        sizedH20,
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: buttonStyle(color: amber),
                              onPressed: () async {
                                if ((formkey.currentState!.validate())) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackbar(
                                          content: 'Data updated !',
                                          color: amber));
                                  await dbHelper.updateDB(amount!, type,
                                      selectedDate, category, index);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (ctx) {
                                    switch (pageIndex) {
                                      case 1:
                                        return const Homepage();
                                      case 2:
                                        return const AllTransactionspage();
                                      case 3:
                                        return const Incomespage();
                                      case 4:
                                        return const Expensepage();
                                      default:
                                        return const Homepage();
                                    }
                                  }), (route) => false);
                                }
                              },
                              child: const TextWidget(
                                text: "Update",
                                maxsize: 18,
                                minsize: 14,
                              )),
                        ),
                        sizedH20,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            CustomPaint(
              painter: MyPainter(),
              child: Container(height: 0),
            ),
          ],
        ));
  }

  Future<void> selectDate(context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 06),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
