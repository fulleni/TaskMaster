import 'package:user_preferences_client/src/models/user_preferences.dart';

/// An abstract class that defines methods for managing user preferences
/// related to theme settings in a Flutter application.
abstract class UserPreferencesClient {
  /// Sets the theme mode.
  /// [themeMode] The new theme mode to be set (light, dark, or system).
  /// Throws [SetThemeModeException] if the theme mode cannot be set.
  Future<void> setThemeMode(UserPreferenceThemeMode themeMode);

  /// Gets the current theme mode.
  /// Throws [GetThemeModeException] if the theme mode cannot be retrieved.
  Future<UserPreferenceThemeMode> getThemeMode();

  /// Sets the main accent color of the theme.
  /// [color] The new primary color to be set.
  /// Throws [SetThemeAccentColorException] if the accent color cannot be set.
  Future<void> setThemeAccentColor(UserPreferenceAccentColor color);

  /// Gets the current theme accent color.
  /// Throws [GetThemeAccentColorException] if the accent color cannot be retrieved.
  Future<UserPreferenceAccentColor> getThemeAccentColor();

  /// Sets the title font size.
  /// [fontSize] The new title font size to be set (small, medium, large).
  /// Throws [SetTitleFontSizeException] if the title font size cannot be set.
  Future<void> setTitleFontSize(UserPreferenceFontSize fontSize);

  /// Gets the current title font size.
  /// Throws [GetTitleFontSizeException] if the title font size cannot be retrieved.
  Future<UserPreferenceFontSize> getTitleFontSize();

  /// Sets the body font size.
  /// [fontSize] The new body font size to be set (small, medium, large).
  /// Throws [SetBodyFontSizeException] if the body font size cannot be set.
  Future<void> setBodyFontSize(UserPreferenceFontSize fontSize);

  /// Gets the current body font size.
  /// Throws [GetBodyFontSizeException] if the body font size cannot be retrieved.
  Future<UserPreferenceFontSize> getBodyFontSize();

  /// Sets the font family.
  /// [fontFamily] The new font family to be set.
  /// Throws [SetFontFamilyException] if the font family cannot be set.
  Future<void> setFontFamily(UserPreferenceGoogleFontsFamily fontFamily);

  /// Gets the current font family.
  /// Throws [GetFontFamilyException] if the font family cannot be retrieved.
  Future<UserPreferenceGoogleFontsFamily> getFontFamily();

  /// Sets the language.
  /// [language] The new language to be set (English, Arabic).
  /// Throws [SetLanguageException] if the language cannot be set.
  Future<void> setLanguage(UserPreferenceLanguage language);

  /// Gets the current language.
  /// Throws [GetLanguageException] if the language cannot be retrieved.
  Future<UserPreferenceLanguage> getLanguage();

  /// Resets all preferences to their default values.
  /// Throws [ResetPreferencesException] if the preferences cannot be reset.
  Future<void> resetPreferences();

  /// Gets all preferences at once.
  /// Throws [GetAllPreferencesException] if the preferences cannot be retrieved.
  Stream<UserPreferences> getAllPreferences();
}

/// Enum representing different theme modes.
enum UserPreferenceThemeMode {
  light,
  dark,
  system,
}

/// Enum representing different accent colors suitable for a dark grey background.
enum UserPreferenceAccentColor {
  blue,
  grey,
  red,
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

extension UserPreferenceGoogleFontsFamilyExtension
    on UserPreferenceGoogleFontsFamily {
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

/// Exception thrown when the theme mode cannot be set.
class SetThemeModeException implements Exception {
  final String message;
  SetThemeModeException(this.message);
}

/// Exception thrown when the theme mode cannot be retrieved.
class GetThemeModeException implements Exception {
  final String message;
  GetThemeModeException(this.message);
}

/// Exception thrown when the theme accent color cannot be set.
class SetThemeAccentColorException implements Exception {
  final String message;
  SetThemeAccentColorException(this.message);
}

/// Exception thrown when the theme accent color cannot be retrieved.
class GetThemeAccentColorException implements Exception {
  final String message;
  GetThemeAccentColorException(this.message);
}

/// Exception thrown when the title font size cannot be set.
class SetTitleFontSizeException implements Exception {
  final String message;
  SetTitleFontSizeException(this.message);
}

/// Exception thrown when the title font size cannot be retrieved.
class GetTitleFontSizeException implements Exception {
  final String message;
  GetTitleFontSizeException(this.message);
}

/// Exception thrown when the body font size cannot be set.
class SetBodyFontSizeException implements Exception {
  final String message;
  SetBodyFontSizeException(this.message);
}

/// Exception thrown when the body font size cannot be retrieved.
class GetBodyFontSizeException implements Exception {
  final String message;
  GetBodyFontSizeException(this.message);
}

/// Exception thrown when the font family cannot be set.
class SetFontFamilyException implements Exception {
  final String message;
  SetFontFamilyException(this.message);
}

/// Exception thrown when the font family cannot be retrieved.
class GetFontFamilyException implements Exception {
  final String message;
  GetFontFamilyException(this.message);
}

/// Exception thrown when the language cannot be set.
class SetLanguageException implements Exception {
  final String message;
  SetLanguageException(this.message);
}

/// Exception thrown when the language cannot be retrieved.
class GetLanguageException implements Exception {
  final String message;
  GetLanguageException(this.message);
}

/// Exception thrown when preferences cannot be reset.
class ResetPreferencesException implements Exception {
  final String message;
  ResetPreferencesException(this.message);
}

/// Exception thrown when all preferences cannot be retrieved.
class GetAllPreferencesException implements Exception {
  final String message;
  GetAllPreferencesException(this.message);
}
