import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../res/config/size_config.dart';

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

  static void showMeetToast(String message, int gravity) {
    ToastGravity toastGravity;

    switch (gravity) {
      case 0:
        toastGravity = ToastGravity.TOP;
        break;
      case 1:
        toastGravity = ToastGravity.CENTER;
        break;
      case 2:
        toastGravity = ToastGravity.BOTTOM;
        break;
      default:
        toastGravity = ToastGravity.BOTTOM; // 기본값은 BOTTOM으로 설정
        break;
    }

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastGravity,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xffFE6059),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static void showCopyToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[200],
      textColor: Colors.black,
      fontSize: SizeConfig.defaultSize * 1.6,
    );
  }

  static void showAddFriendToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff7C83FD),
      textColor: Colors.white,
      fontSize: SizeConfig.defaultSize * 1.6,
    );
  }

  static void itsMyCodeToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff7C83FD),
      textColor: Colors.white,
      fontSize: SizeConfig.defaultSize * 1.6,
    );
  }
}
