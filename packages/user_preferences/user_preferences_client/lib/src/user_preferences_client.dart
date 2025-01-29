import 'package:flutter/material.dart';

/// An abstract class that defines methods for managing user preferences
/// related to theme settings in a Flutter application.
abstract class UserPreferencesClient {
  
  /// Changes the theme mode.
  /// [themeMode] The new theme mode to be set (light, dark, or system).
  Future<void> changeThemeMode(ThemeMode themeMode);
  
  /// Changes the main accent color of the theme.
  /// [color] The new primary color to be set.
  Future<void> changeThemeAccentColor(MaterialColor color);

}