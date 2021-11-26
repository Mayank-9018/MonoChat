import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionHandleColor: Colors.black,
      selectionColor: Colors.grey.shade300),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black),
  cardColor: Colors.grey.shade200,
);
