import 'package:flutter/material.dart';

//TODO: Define text theme
ThemeData lightTheme = ThemeData(
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.grey.shade100),
          foregroundColor: MaterialStateProperty.all(Colors.black))),
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
