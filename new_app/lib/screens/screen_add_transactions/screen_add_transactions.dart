import 'package:flutter/material.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/widgets/button_style.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/common_appbar.dart';
import 'package:new_app/widgets/container_decoration.dart';
import 'package:new_app/widgets/months_list.dart';
import 'package:new_app/widgets/painter_class.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/toast.dart';
import 'package:new_app/widgets/text_widget.dart';
import 'package:new_app/widgets/textfield_border.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransactionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> opacity;
  late Animation<double> _transform;
  GlobalKey<FormState> addformKey1 = GlobalKey();
  int? amount;
  String category = 'No category Added';
  String type = 'Income';
  DateTime selectedDate = DateTime.now();

  final amountController = TextEditingController();
  final catController = TextEditingController();
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });
    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarcommon(pageHeading: "Add Transactions")),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Transform.scale(
                  scale: _transform.value,
                  child: Center(
                    child: Container(
                      width: size.width * .9,
                      height: size.width * 1.1,
                      decoration: containerDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Form(
                            key: addformKey1,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  sizedH20,
                                  TextFormField(
                                      controller: amountController,
                                      validator: (value) {
                                        return (value == null || value.isEmpty)
                                            ? 'Please enter an amount '
                                            : null;
                                      },
                                      maxLength: 15,
                                      decoration: textFiledDecorations(
                                          "Amount...",
                                          Icons
                                              .account_balance_wallet_outlined),
                                      style:
                                          const TextStyle(color: scaffoldbgnew),
                                      onChanged: (val) {
                                        amount = int.parse(val);
                                      },
                                      keyboardType: TextInputType.number),
                                  sizedH20,
                                  TextFormField(
                                      controller: catController,
                                      validator: (value) {
                                        return (value == null || value.isEmpty)
                                            ? 'Please enter a category '
                                            : null;
                                      },
                                      decoration: textFiledDecorations(
                                          "Category...",
                                          Icons.category_outlined),
                                      style: const TextStyle(
                                        color: scaffoldbgnew,
                                      ),
                                      onChanged: (val) {
                                        category = val;
                                      }),
                                  sizedH20,
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 12),
                                        ChoiceChip(
                                            label: Text('Income',
                                                style: TextStyle(
                                                    fontFamily: 'Comfortaa',
                                                    color: type == 'Income'
                                                        ? white
                                                        : scaffoldbgnew)),
                                            selectedColor: amber,
                                            backgroundColor: white,
                                            selected: (type == 'Income')
                                                ? true
                                                : false,
                                            onSelected: (val) {
                                              if (val) {
                                                setState(() {
                                                  type = 'Income';
                                                });
                                              }
                                            }),
                                        const SizedBox(width: 12),
                                        ChoiceChip(
                                            label: TextWidget(
                                                maxsize: 22,
                                                minsize: 17,
                                                text: "Expense",
                                                family: 'Comfortaa',
                                                color: type == 'Expense'
                                                    ? white
                                                    : scaffoldbgnew),
                                            selectedColor: amber,
                                            backgroundColor: white,
                                            selected: type == 'Expense'
                                                ? true
                                                : false,
                                            onSelected: (val) {
                                              if (val) {
                                                setState(() {
                                                  type = 'Expense';
                                                });
                                              }
                                            })
                                      ]),
                                  sizedH20,
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
                                  ElevatedButton(
                                      style: buttonStyle(color: amber),
                                      onPressed: () async {
                                        if ((addformKey1.currentState!
                                            .validate())) {
                                          toastMessage("Data Added !");
                                          DbHelper dbHelper = DbHelper();
                                          await dbHelper.addtoDB(amount!, type,
                                              selectedDate, category);
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Homepage()),
                                                  (route) => false);
                                        }
                                      },
                                      child: const TextWidget(
                                        text: "Add",
                                        maxsize: 18,
                                        minsize: 14,
                                      )),
                                  sizedH20,
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomPaint(
            painter: MyPainter(),
            child: Container(height: 0),
          ),
        ],
      ),
    );
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

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
