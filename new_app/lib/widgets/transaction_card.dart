import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_app/db_helper/transactions_model.dart';
import 'package:new_app/functions/confirm_delete.dart';
import 'package:new_app/screens/screen_update/screen_update.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/months_list.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/text_widget.dart';



class Cards extends StatefulWidget {
  const Cards({Key? key, required this.index, required this.data})
      : super(key: key);
  final int index;
  final TransactionModel data;
  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    selectedDate = widget.data.dateTime;
    String date = "${selectedDate!.day} ${monthsList[selectedDate!.month - 1]}";

    return Slidable(
        direction: Axis.horizontal,
        key: Key(widget.index.toString()),
        // startActionPane:,
        startActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              setState(() {
                confirmDelete(widget.index, context);
              });
            },
            backgroundColor: red,
            foregroundColor: white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) =>
                Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  Updatescreen(data: widget.data, index: widget.index),
            )),
            backgroundColor: amber,
            foregroundColor:white,
            icon: Icons.update,
            label: 'Edit',
          ),
        ]),
        child: Transform.translate(
          offset: const Offset(0, 1.2),
          child: InkWell(
            enableFeedback: true,
            onTap: () {},
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Container(
              margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
              padding: EdgeInsets.all(_w / 20),
              height: _w / 4.4,
              width: _w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(.1),
                    radius: _w / 15,
                    child: widget.data.type == "Income"
                        ? const Icon(Icons.arrow_drop_up_sharp,
                            size: 40, color: green)
                        : const Icon(
                            Icons.arrow_drop_down_sharp,
                            size: 40,
                            color: red,
                          ),
                  ),
                  sizedW10,
                  Container(
                    alignment: Alignment.centerLeft,
                    width: _w / 2.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: '${widget.data.amount}',
                          minsize: 14,
                          maxsize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(.7),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontFamily: fontComforataa,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(.8),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextWidget(
                    text: widget.data.category,
                    color: scaffoldbgnew,
                    minsize: 5,
                    maxsize: 18,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
