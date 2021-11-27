import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.grey.shade800),
            foregroundColor: MaterialStateProperty.all(Colors.white))),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionHandleColor: Colors.white,
        selectionColor: Colors.grey[800]),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme:
        const AppBarTheme(elevation: 0.0, backgroundColor: Colors.black),
    cardColor: Colors.grey[900]);
