import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/widgets/colors.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

// SnackBar snackbar({required String content, Color color=amber}) {
//   return SnackBar(
// dismissDirection: DismissDirection.down,
// duration: const Duration(seconds: 1),
// // behavior: SnackBarBehavior.floating,
// shape: RoundedRectangleBorder(
//   borderRadius: BorderRadius.circular(10.0),
// ),
// backgroundColor: color,
// content:  Text(content),
// );
// }
Future<bool?> toastMessage(String msg) {
  return Fluttertoast.showToast(
      backgroundColor: green, gravity: ToastGravity.SNACKBAR, msg: msg);
}
