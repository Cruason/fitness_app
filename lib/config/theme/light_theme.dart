import 'package:fitness_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
      background: Colors.white,
      primary: Color(0xFFF08700),
      secondary: Color(0XFF979AA0)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Color(0XFFF08700),
      unselectedItemColor: Color(0XFFFFFDFD)),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Montserrat',
        fontSize: 24,
        height: 1,
        fontWeight: FontWeight.w600),
    headlineLarge: TextStyle(
        color: Color(0XFFF08700),
        fontFamily: 'Montserrat',
        fontSize: 36,
        height: 1,
        fontWeight: FontWeight.w400),
    titleLarge: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 16,
      height: 1,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontFamily: 'Montserrat',
      fontSize: 14,
      height: 1,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge:  TextStyle(
      color: Color(0xFF474747),
      fontFamily: 'Montserrat',
      fontSize: 18,
      height: 1,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium:  TextStyle(
      color: Color(0xFF979AA0),
      fontFamily: 'Montserrat',
      fontSize: 14,
      height: 1,
      fontWeight: FontWeight.w500,
    ),
  ),
);
