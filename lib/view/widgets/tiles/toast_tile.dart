import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String message, [bool green = true]) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor:
        green ? Colors.green : const Color.fromARGB(255, 209, 98, 90),
    textColor: Colors.white,
    fontSize: 14,
  );
}
