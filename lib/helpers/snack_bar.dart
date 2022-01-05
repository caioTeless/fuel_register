import 'package:flutter/material.dart';

class SnackBarApp {
  static SnackBar snackBar(
      {required String text, String? action, Function()? actionFunction}) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0xFF1ABC9C),
      elevation: 2,
      behavior: SnackBarBehavior.fixed,
      action: action != null
          ? SnackBarAction(
              label: action,
              onPressed: actionFunction!,
              textColor: Colors.yellow,

            )
          : SnackBarAction(
              label: '',
              onPressed: () {},
            ),
    );
  }
}
