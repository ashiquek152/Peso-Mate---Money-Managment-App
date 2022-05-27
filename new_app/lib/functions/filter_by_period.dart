import 'package:flutter/material.dart';
import 'package:new_app/widgets/transaction_card.dart';

filterExpenseandIncome( 
    dataAtindex,
    tappedMonth,
    dropdownValue,
    index,
    todayDate) {
  if (tappedMonth == dataAtindex.dateTime.month &&
      dropdownValue == "This year" &&
      dataAtindex.dateTime.year == todayDate.year) {
    {
      return Cards(data: dataAtindex, index: index);
    }
  } else if (dropdownValue == "All") {
    {
      return Cards(data: dataAtindex, index: index);
    }
  } else if (dropdownValue == "Today" &&
      dataAtindex.dateTime.month == todayDate.month &&
      dataAtindex.dateTime.day == todayDate.day) {
    {
      return Cards(data: dataAtindex, index: index);
    }
  } else if (dropdownValue == "This month" &&
      dataAtindex.dateTime.month == todayDate.month) {
    {
      return Cards(
        data: dataAtindex,
        index: index,
      );
    }
  } else {
    return const SizedBox();
  }
}
