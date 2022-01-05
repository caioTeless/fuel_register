import 'package:flutter/material.dart';
class ThisAppBar {
  static AppBar appBar(String title) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: const Color(0xFF1ABC9C),
    );
  }
}
