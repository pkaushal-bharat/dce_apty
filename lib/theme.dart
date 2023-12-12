import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Define your primary and accent colors
const primaryColor = Colors.blue;
const accentColor = Colors.green;

// Define the theme for your app
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
      color: Colors.black, // Change the default text color
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
    // Add more text styles as needed
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: primaryColor, // Default button color
    textTheme: ButtonTextTheme.primary,
  ),
);
