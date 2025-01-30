import 'package:user_preferences_client/user_preferences_client.dart';

/// Repository that manages user preferences.
class UserPreferencesRepository {
  final UserPreferencesClient _client;

  /// Creates a [UserPreferencesRepository] with the given [UserPreferencesClient].
  ///
  /// The [client] parameter must not be null.
  UserPreferencesRepository({required UserPreferencesClient client})
      : _client = client;

  /// Sets the theme mode.
  ///
  /// Throws [SetThemeModeException] if the theme mode cannot be set.
  Future<void> setThemeMode(UserPreferenceThemeMode themeMode) async {
    try {
      await _client.setThemeMode(themeMode);
    } catch (e) {
      throw SetThemeModeException('Failed to set theme mode: $e');
    }
  }

  /// Gets the current theme mode.
  ///
  /// Throws [GetThemeModeException] if the theme mode cannot be retrieved.
  Future<UserPreferenceThemeMode> getThemeMode() async {
    try {
      return await _client.getThemeMode();
    } catch (e) {
      throw GetThemeModeException('Failed to get theme mode: $e');
    }
  }

  /// Sets the main accent color of the theme.
  ///
  /// Throws [SetThemeAccentColorException] if the accent color cannot be set.
  Future<void> setThemeAccentColor(UserPreferenceAccentColor color) async {
    try {
      await _client.setThemeAccentColor(color);
    } catch (e) {
      throw SetThemeAccentColorException(
          'Failed to set theme accent color: $e');
    }
  }

  /// Gets the current theme accent color.
  ///
  /// Throws [GetThemeAccentColorException] if the accent color cannot be retrieved.
  Future<UserPreferenceAccentColor> getThemeAccentColor() async {
    try {
      return await _client.getThemeAccentColor();
    } catch (e) {
      throw GetThemeAccentColorException(
          'Failed to get theme accent color: $e');
    }
  }

  /// Sets the app font size.
  ///
  /// Throws [SetAppFontSizeException] if the title font size cannot be set.
  Future<void> setFontSize(UserPreferenceFontSize fontSize) async {
    try {
      await _client.setFontSize(fontSize);
    } catch (e) {
      throw SetAppFontSizeException('Failed to set app font size: $e');
    }
  }

  /// Gets the current app font size.
  ///
  /// Throws [GetAppFontSizeException] if the title font size cannot be retrieved.
  Future<UserPreferenceFontSize> getFontSize() async {
    try {
      return await _client.getFontSize();
    } catch (e) {
      throw GetAppFontSizeException('Failed to get app font size: $e');
    }
  }

  /// Sets the font family.
  ///
  /// Throws [SetFontFamilyException] if the font family cannot be set.
  Future<void> setFontFamily(UserPreferenceGoogleFontsFamily fontFamily) async {
    try {
      await _client.setFontFamily(fontFamily);
    } catch (e) {
      throw SetFontFamilyException('Failed to set font family: $e');
    }
  }

  /// Gets the current font family.
  ///
  /// Throws [GetFontFamilyException] if the font family cannot be retrieved.
  Future<UserPreferenceGoogleFontsFamily> getFontFamily() async {
    try {
      return await _client.getFontFamily();
    } catch (e) {
      throw GetFontFamilyException('Failed to get font family: $e');
    }
  }

  /// Sets the language.
  ///
  /// Throws [SetLanguageException] if the language cannot be set.
  Future<void> setLanguage(UserPreferenceLanguage language) async {
    try {
      await _client.setLanguage(language);
    } catch (e) {
      throw SetLanguageException('Failed to set language: $e');
    }
  }

  /// Gets the current language.
  ///
  /// Throws [GetLanguageException] if the language cannot be retrieved.
  Future<UserPreferenceLanguage> getLanguage() async {
    try {
      return await _client.getLanguage();
    } catch (e) {
      throw GetLanguageException('Failed to get language: $e');
    }
  }

  /// Resets all preferences to their default values.
  ///
  /// Throws [ResetPreferencesException] if the preferences cannot be reset.
  Future<void> resetPreferences() async {
    try {
      await _client.resetPreferences();
    } catch (e) {
      throw ResetPreferencesException('Failed to reset preferences: $e');
    }
  }

  /// Gets all preferences at once.
  ///
  /// Throws [GetAllPreferencesException] if the preferences cannot be retrieved.
  Stream<UserPreferences> getAllPreferences() {
    try {
      return _client.getAllPreferences();
    } catch (e) {
      throw GetAllPreferencesException('Failed to get all preferences: $e');
    }
  }
}
