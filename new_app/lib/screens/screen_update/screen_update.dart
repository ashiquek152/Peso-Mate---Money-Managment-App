import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/widgets/button_style.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/container_decoration.dart';
import 'package:new_app/widgets/months_list.dart';
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
    return Scaffold(
        backgroundColor: scaffoldbgnew,
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: const EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left_circle,
                    size: 40,
                    color: white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(15),
              height: 430,
              width: MediaQuery.of(context).size.width,
              decoration: ContainerDecoration(),
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    sizedH20,
                    type == "Expense"
                        ? const Center(
                            child: TextWidget(
                            text: 'Edit Expense',
                            fontWeight: FontWeight.w700,
                            color: white,
                            maxsize: 26,
                            minsize: 22,
                          ))
                        : const Center(
                            child: TextWidget(
                            text: 'Edit Income',
                            fontWeight: FontWeight.w700,
                            color: white,
                            maxsize: 26,
                            minsize: 22,
                          )),
                    sizedH20,
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(12.0),
                            child: const SizedBox(
                              width: 25,
                              height: 25,
                              child: Center(
                                child: Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 25.0,
                                    color: white),
                              ),
                            )),
                        const SizedBox(width: 12),
                        Expanded(
                            child: TextFormField(
                                controller: amountController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an amount  ';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    fillColor: scaffoldbgnew,
                                    filled: true,
                                    hintText: 'Amount',
                                    hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(92, 255, 255, 255)),
                                    enabledBorder: textFieldBorderStyle(),
                                    focusedBorder: textFieldBorderStyle(),
                                    errorBorder:
                                        textFieldBorderStyle(color: red),
                                    focusedErrorBorder:
                                        textFieldBorderStyle(color: red),
                                    suffixText: '₹'),
                                style: const TextStyle(color: white),
                                onChanged: (val) {
                                  amount = int.parse(val);
                                },
                                keyboardType: TextInputType.number)),
                      ],
                    ),
                    sizedH20,
                    Row(
                      children: [
                        Container(
                            // decoration: iconboxDecoration,
                            padding: const EdgeInsets.all(12.0),
                            child: const SizedBox(
                                width: 25,
                                height: 25,
                                child: Icon(Icons.category,
                                    size: 25.0, color: white))),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: catController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a category max : 20';
                              } else {
                                return null;
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            decoration: InputDecoration(
                              fillColor: scaffoldbgnew,
                              filled: true,
                              hintText: 'Category..',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(92, 255, 255, 255)),
                              enabledBorder: textFieldBorderStyle(),
                              focusedBorder: textFieldBorderStyle(),
                              errorBorder: textFieldBorderStyle(color: red),
                              focusedErrorBorder:
                                  textFieldBorderStyle(color: red),
                            ),
                            style: const TextStyle(
                              color: white,
                            ),
                            onChanged: (val) {
                              category = val;
                            },
                          ),
                        ),
                      ],
                    ),
                    sizedH20,
                    Row(
                      children: [
                        Container(
                            // decoration: iconboxDecoration,
                            padding: const EdgeInsets.all(12.0),
                            child: const SizedBox(
                              width: 25,
                              height: 25,
                              child: Icon(
                                Icons.date_range,
                                size: 25.0,
                                color: white,
                              ),
                            )),
                        SizedBox(
                          height: 50,
                          child: TextButton(
                              onPressed: () {
                                selectDate(context);
                              },
                              child: TextWidget(
                                text:
                                    "${selectedDate.day} ${monthsList[selectedDate.month - 1]}",
                                maxsize: 18,
                                minsize: 14,
                              )),
                        ),
                      ],
                    ),
                    sizedH20,
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: buttonStyle(color: green),
                          onPressed: () async {
                            if ((formkey.currentState!.validate())) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackbar(
                                      content: 'Data updated !', color: green));
                              await dbHelper.updateDB(
                                  amount!, type, selectedDate, category, index);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (ctx) {
                                return const Homepage();
                              }));
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
