import 'package:flutter/material.dart';
import 'package:news/config/colors.dart';

class AppTheme {
  static ThemeData mTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mGreen),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.mBlack,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}