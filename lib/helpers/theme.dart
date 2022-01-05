import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primaryColor: const Color(0xFF1ABC9C),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  applyElevationOverlayColor: false,
  appBarTheme: const AppBarTheme(color: Colors.white),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
    ),
  ),
);
