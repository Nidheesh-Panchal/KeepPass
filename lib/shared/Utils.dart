import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showErrorSnackBar(String? text) {
    if (text == null) {
      return;
    }

    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  static showInfoSnackBar(String? text) {
    if (text == null) {
      return;
    }

    final snackbar = SnackBar(
      content: Text(text),
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
