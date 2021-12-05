import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    Color background = const Color(0xFFFFFFFF);
    Color primary = const Color(0xff6cbe77);
    Color secondary = const Color(0xff262c24);

    return ThemeData(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(backgroundColor: primary),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: primary, secondary: secondary),
    );
  }
}
