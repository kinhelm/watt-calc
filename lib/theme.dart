// lib/theme.dart
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.lightBlue[300],
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.lightBlueAccent,
  ),
  scaffoldBackgroundColor: Colors.lightBlue[50],
  textTheme: TextTheme(
    bodyMedium: TextStyle(fontSize: 18.0, color: Colors.blue[900]),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue[700]!),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue[300]!),
    ),
    labelStyle: TextStyle(color: Colors.blue[700]),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[600],
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.lightBlue[300],
  ),
);