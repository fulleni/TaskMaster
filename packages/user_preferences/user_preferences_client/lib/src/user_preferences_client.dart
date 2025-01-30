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

  /// Sets the app font size.
  /// [fontSize] The new app font size to be set (small, medium, large).
  /// Throws [SetAppFontSizeException] if the app font size cannot be set.
  Future<void> setFontSize(UserPreferenceFontSize fontSize);

  /// Gets the current app font size.
  /// Throws [GetAppFontSizeException] if the app font size cannot be retrieved.
  Future<UserPreferenceFontSize> getFontSize();

  /// Sets the font family.
  /// [fontFamily] The new font family to be set.
  /// Throws [SetFontFamilyException] if the font family cannot be set.
  Future<void> setFontFamily(UserPreferenceFontFamily fontFamily);

  /// Gets the current font family.
  /// Throws [GetFontFamilyException] if the font family cannot be retrieved.
  Future<UserPreferenceFontFamily> getFontFamily();

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
  defaultSize,
  mediumSize,
  largeSize,
}

extension UserPreferenceFontSizeX on UserPreferenceFontSize {
  /// Returns a display string for [UserPreferenceFontSize].
  static String toDisplayString(UserPreferenceFontSize fontSize) {
    switch (fontSize) {
      case UserPreferenceFontSize.defaultSize:
        return 'default';
      case UserPreferenceFontSize.mediumSize:
        return 'medium';
      case UserPreferenceFontSize.largeSize:
        return 'large';
    }
  }
}

/// Enum representing different font families from Google Fonts.
enum UserPreferenceFontFamily {
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

/// Enum representing different languages.
enum UserPreferenceLanguage {
  english,
  arabic,
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

/// Exception thrown when the app font size cannot be set.
class SetAppFontSizeException implements Exception {
  final String message;
  SetAppFontSizeException(this.message);
}

/// Exception thrown when the app font size cannot be retrieved.
class GetAppFontSizeException implements Exception {
  final String message;
  GetAppFontSizeException(this.message);
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
