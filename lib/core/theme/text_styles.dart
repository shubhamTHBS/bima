import 'package:flutter/material.dart';

/// General __Font__ used throughout the application
class Font {
  static const String ROBOTO = 'Roboto';
  static const String ROBOTO_CONDENSED_BOLD = 'Roboto Condensed Bold';
  static const String ROBOTO_CONDENSED_REGULAR = 'Roboto Condensed Regular';
}

/// General __TextStyles__ used throughout the application
class TextStyles {
  static const TextStyle roboto = TextStyle(fontFamily: Font.ROBOTO);
  static const TextStyle robotoCondensedBold =
      TextStyle(fontFamily: Font.ROBOTO_CONDENSED_BOLD);
  static const TextStyle robotoCondensedRegular =
      TextStyle(fontFamily: Font.ROBOTO_CONDENSED_REGULAR);
}
