import 'package:flutter/material.dart';
import 'app_theme.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorTheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  bool get isDarkMode => theme.brightness == Brightness.dark;

  EmotionalTheme get emo => theme.extension<EmotionalTheme>()!;
}
