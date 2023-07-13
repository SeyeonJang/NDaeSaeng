import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1, // iOS 및 web에서 시간
        backgroundColor: const Color(0xff7C83FD),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
