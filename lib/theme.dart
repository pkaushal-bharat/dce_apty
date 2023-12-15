import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const primaryColor = Color(0xFF2196F3); // Royal blue
const accentColor = Color(0xFF4CAF50); // Mint green
const tertiaryColor = Color(0xFFF44336); // Coral

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  hintColor: accentColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: primaryColor,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.black87,
      fontSize: 16.0,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: accentColor,
    unselectedItemColor: Colors.grey[600],
  ),
);
