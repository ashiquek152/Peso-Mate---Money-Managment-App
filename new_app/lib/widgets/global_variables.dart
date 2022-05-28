  import 'package:flutter/foundation.dart';
import 'package:new_app/db_helper/transactions_model.dart';

List<TransactionModel> snapshotData=[];
int pageIndex=0;
ValueNotifier <bool> dataChanged= ValueNotifier(false);