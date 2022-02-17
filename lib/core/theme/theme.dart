import 'package:bima/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'color.dart';

/// Class for custom __ThemeData__ where multiple `themes` can be defined
class AppTheme {
  static ThemeData get light {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColor.primaryColor,
        primaryColorDark: AppColor.primaryColorDark,
        splashColor: Colors.transparent,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: AppColor.accentColor),
        fontFamily: Font.ROBOTO);
  }
}
