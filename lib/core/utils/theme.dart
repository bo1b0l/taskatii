import 'package:flutter/material.dart';
import 'package:tasaktii/core/utils/colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkscaffold,
    appBarTheme:
        AppBarTheme(backgroundColor: AppColors.darkscaffold, centerTitle: true),
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary, onSurface: AppColors.white),
    datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.darkscaffold,
        headerForegroundColor: AppColors.primary),
    timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColors.darkscaffold,
        dialTextColor: AppColors.primary,
        dialBackgroundColor: AppColors.darkscaffold,
        hourMinuteColor: AppColors.darkscaffold,
        hourMinuteTextColor: AppColors.primary),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.red))),
  );

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme:
        AppBarTheme(backgroundColor: AppColors.white, centerTitle: true),
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary, onSurface: AppColors.black),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.white,
      headerForegroundColor: AppColors.primary,
    ),
    timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColors.white,
        dialTextColor: AppColors.primary,
        dialBackgroundColor: AppColors.white,
        hourMinuteColor: AppColors.white,
        hourMinuteTextColor: AppColors.primary),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.red))),
  );
}
