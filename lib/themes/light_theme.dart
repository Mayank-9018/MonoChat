import 'package:flutter/material.dart';

//TODO: Define text theme
ThemeData lightTheme = ThemeData(
  progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.black,
      circularTrackColor: Colors.grey[200],
      linearTrackColor: Colors.grey[200]),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.grey.shade900),
          backgroundColor: MaterialStateProperty.all(Colors.black))),
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
