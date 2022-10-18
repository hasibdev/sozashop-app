import 'package:flutter/material.dart';
import 'package:sozashop_app/core/constants/colors.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    primarySwatch: KColors.primary,
    canvasColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // backgroundColor: Colors.brown.shade50,
        ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}


// titleTextStyle: const TextStyle().copyWith(color: Colors.black),