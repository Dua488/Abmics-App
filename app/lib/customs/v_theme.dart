import 'package:amlportal/customs/v_chip_theme.dart';
import 'package:flutter/material.dart';
import 'v_text_theme.dart';
import 'v_appbar_theme.dart';
import 'v_checkbox_theme.dart';
import 'v_bottom_sheet_theme.dart';
import 'v_elevated_button_theme.dart';
import 'v_outline_button_theme.dart';
import 'v_text_form_field_theme.dart';

class VAppTheme{
  VAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Kantumruy',
      brightness: Brightness.light,
      primaryColor: Colors.blue[900],
      // textTheme: VTextTheme.lightTextTheme,
      // chipTheme: VChipTheme.lightChipTheme,
      scaffoldBackgroundColor: Colors.white,
      // appBarTheme: VAppBarTheme.lightAppBarTheme,
      // checkboxTheme: VCheckboxTheme.lightCheckboxTheme,
      // bottomSheetTheme: VBottomSheetTheme.lightBottomSheetTheme,
      // elevatedButtonTheme: VElevatedButtonTheme.lightElevatedButtonTheme,
      // outlinedButtonTheme: VOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: VTextFormFieldTheme.lightInputDecorationTheme
  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Kantumruy',
      brightness: Brightness.dark,
      primaryColor: Colors.blue[900],
      textTheme: VTextTheme.darkTextTheme,
      chipTheme: VChipTheme.darkChipTheme,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: VAppBarTheme.darkAppBarTheme,
      checkboxTheme: VCheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: VBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: VElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: VOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: VTextFormFieldTheme.darkInputDecorationTheme
  );

}