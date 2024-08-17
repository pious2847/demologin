import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SnackbarUtils {
  static void showCustomSnackBar(BuildContext context, String message, Color backgroundColor) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () => scaffold.hideCurrentSnackBar(),
        ),
        duration: Duration(seconds: 4),
      ),
    );
  }
}

class ToastMsg {
  static void showToastMsg(String message, {Color? backgroundColor, ToastGravity? gravity}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor ?? Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showSuccessToast(String message) {
    showToastMsg(message, backgroundColor: const Color.fromARGB(197, 76, 175, 79));
  }

  static void showErrorToast(String message) {
    showToastMsg(message, backgroundColor: const Color.fromARGB(197, 244, 67, 54));
  }

  static void showInfoToast(String message) {
    showToastMsg(message, backgroundColor: const Color.fromARGB(202, 33, 149, 243));
  }
}