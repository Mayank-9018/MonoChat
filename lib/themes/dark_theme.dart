import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.white,
        circularTrackColor: Colors.grey[900],
        linearTrackColor: Colors.grey[900]),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.grey[800]),
            backgroundColor: MaterialStateProperty.all(Colors.grey[900]))),
    dialogTheme: const DialogTheme(
        backgroundColor: Colors.black,
        elevation: 24.0,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 0.8),
            borderRadius: BorderRadius.all(Radius.circular(8.0)))),
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
