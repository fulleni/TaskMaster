import 'package:flutter/material.dart';

/// An abstract class that defines methods for managing user preferences
/// related to theme settings in a Flutter application.
abstract class UserPreferencesClient {
  /// Changes the theme mode.
  /// [themeMode] The new theme mode to be set (light, dark, or system).
  Future<void> setThemeMode(ThemeMode themeMode);

  /// Gets the current theme mode.
  Future<ThemeMode> getThemeMode();

  /// Changes the main accent color of the theme.
  /// [color] The new primary color to be set.
  Future<void> setThemeAccentColor(MaterialColor color);

  /// Gets the current theme accent color.
  Future<MaterialColor> getThemeAccentColor();

  /// Sets the title font size.
  /// [fontSize] The new title font size to be set (small, medium, large).
  Future<void> setTitleFontSize(UserPreferenceFontSize fontSize);

  /// Gets the current title font size.
  Future<UserPreferenceFontSize> getTitleFontSize();

  /// Sets the body font size.
  /// [fontSize] The new body font size to be set (small, medium, large).
  Future<void> setBodyFontSize(UserPreferenceFontSize fontSize);

  /// Gets the current body font size.
  Future<UserPreferenceFontSize> getBodyFontSize();

  /// Sets the font family.
  /// [fontFamily] The new font family to be set.
  Future<void> setFontFamily(UserPreferenceGoogleFontsFamily fontFamily);

  /// Gets the current font family.
  Future<UserPreferenceGoogleFontsFamily> getFontFamily();

  /// Sets the language.
  /// [language] The new language to be set (English, Arabic).
  Future<void> setLanguage(UserPreferenceLanguage language);

  /// Gets the current language.
  Future<UserPreferenceLanguage> getLanguage();
}

/// Enum representing different font sizes.
enum UserPreferenceFontSize {
  small,
  medium,
  large,
}

extension UserPreferenceFontSizeExtension on UserPreferenceFontSize {
  double get titleSize {
    switch (this) {
      case UserPreferenceFontSize.small:
        return 18.0;
      case UserPreferenceFontSize.medium:
        return 24.0;
      case UserPreferenceFontSize.large:
        return 30.0;
    }
  }

  double get bodySize {
    switch (this) {
      case UserPreferenceFontSize.small:
        return 14.0;
      case UserPreferenceFontSize.medium:
        return 16.0;
      case UserPreferenceFontSize.large:
        return 18.0;
    }
  }
}

/// Enum representing different font families from Google Fonts.
enum UserPreferenceGoogleFontsFamily {
  roboto,
  openSans,
  lato,
  raleway,
  montserrat,
  merriweather,
  nunito,
  playfairDisplay,
  sourceSansPro,
  ubuntu,
}

extension UserPreferenceGoogleFontsFamilyExtension on UserPreferenceGoogleFontsFamily {
  String get name {
    switch (this) {
      case UserPreferenceGoogleFontsFamily.roboto:
        return 'Roboto';
      case UserPreferenceGoogleFontsFamily.openSans:
        return 'Open Sans';
      case UserPreferenceGoogleFontsFamily.lato:
        return 'Lato';
      case UserPreferenceGoogleFontsFamily.raleway:
        return 'Raleway';
      case UserPreferenceGoogleFontsFamily.montserrat:
        return 'Montserrat';
      case UserPreferenceGoogleFontsFamily.merriweather:
        return 'Merriweather';
      case UserPreferenceGoogleFontsFamily.nunito:
        return 'Nunito';
      case UserPreferenceGoogleFontsFamily.playfairDisplay:
        return 'Playfair Display';
      case UserPreferenceGoogleFontsFamily.sourceSansPro:
        return 'Source Sans Pro';
      case UserPreferenceGoogleFontsFamily.ubuntu:
        return 'Ubuntu';
    }
  }
}

/// Enum representing different languages.
enum UserPreferenceLanguage {
  english,
  arabic,
}

extension UserPreferenceLanguageExtension on UserPreferenceLanguage {
  String get code {
    switch (this) {
      case UserPreferenceLanguage.english:
        return 'en';
      case UserPreferenceLanguage.arabic:
        return 'ar';
    }
  }
}
