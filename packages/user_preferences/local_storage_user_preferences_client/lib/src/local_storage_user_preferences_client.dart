import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_preferences_client/user_preferences_client.dart';

/// A client for managing user preferences using local storage.
class LocalStorageUserPreferencesClient implements UserPreferencesClient {
  /// Creates a new instance of [LocalStorageUserPreferencesClient].
  LocalStorageUserPreferencesClient({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  /// A [BehaviorSubject] that holds the current user preferences.
  late final _userPreferencesStreamController =
      BehaviorSubject<UserPreferences>.seeded(
    UserPreferences.defaults(),
  );

  static const String _themeModeKey = 'themeMode';
  static const String _themeAccentColorKey = 'themeAccentColor';
  static const String _fontSizeKey = 'fontSize';
  static const String _fontFamilyKey = 'fontFamily';
  static const String _languageKey = 'language';

  /// Updates the stream controller with the new [updatedPreferences].
  void _updateStreamController(UserPreferences updatedPreferences) {
    _userPreferencesStreamController.add(updatedPreferences);
  }

  @override
  Future<void> setThemeMode(UserPreferenceThemeMode themeMode) async {
    try {
      final success = await _sharedPreferences.setString(
          _themeModeKey, themeMode.toString());
      if (!success) throw SetThemeModeException('Failed to set theme mode');
      _updateStreamController(
        (await _userPreferencesStreamController.first)
            .copyWith(themeMode: themeMode),
      );
    } catch (e) {
      throw SetThemeModeException(e.toString());
    }
  }

  @override
  Future<UserPreferenceThemeMode> getThemeMode() async {
    try {
      final themeModeString = _sharedPreferences.getString(_themeModeKey);
      if (themeModeString == null) {
        throw GetThemeModeException('Failed to get theme mode');
      }
      return UserPreferenceThemeMode.values
          .firstWhere((e) => e.toString() == themeModeString);
    } catch (e) {
      throw GetThemeModeException(e.toString());
    }
  }

  @override
  Future<void> setThemeAccentColor(UserPreferenceAccentColor color) async {
    try {
      final success = await _sharedPreferences.setString(
          _themeAccentColorKey, color.toString());
      if (!success) {
        throw SetThemeAccentColorException('Failed to set theme accent color');
      }
      _updateStreamController(
        (await _userPreferencesStreamController.first)
            .copyWith(themeAccentColor: color),
      );
    } catch (e) {
      throw SetThemeAccentColorException(e.toString());
    }
  }

  @override
  Future<UserPreferenceAccentColor> getThemeAccentColor() async {
    try {
      final colorString = _sharedPreferences.getString(_themeAccentColorKey);
      if (colorString == null) {
        throw GetThemeAccentColorException('Failed to get theme accent color');
      }
      return UserPreferenceAccentColor.values
          .firstWhere((e) => e.toString() == colorString);
    } catch (e) {
      throw GetThemeAccentColorException(e.toString());
    }
  }

  @override
  Future<void> setFontSize(UserPreferenceFontSize fontSize) async {
    try {
      final success =
          await _sharedPreferences.setString(_fontSizeKey, fontSize.toString());
      if (!success) {
        throw SetAppFontSizeException('Failed to set app font size');
      }
      _updateStreamController(
        (await _userPreferencesStreamController.first)
            .copyWith(fontSize: fontSize),
      );
    } catch (e) {
      throw SetAppFontSizeException(e.toString());
    }
  }

  @override
  Future<UserPreferenceFontSize> getFontSize() async {
    try {
      final fontSizeString = _sharedPreferences.getString(_fontSizeKey);
      if (fontSizeString == null) {
        throw GetAppFontSizeException('Failed to get app font size');
      }
      return UserPreferenceFontSize.values
          .firstWhere((e) => e.toString() == fontSizeString);
    } catch (e) {
      throw GetAppFontSizeException(e.toString());
    }
  }

  @override
  Future<void> setFontFamily(UserPreferenceFontFamily fontFamily) async {
    try {
      final success = await _sharedPreferences.setString(
          _fontFamilyKey, fontFamily.toString());
      if (!success) throw SetFontFamilyException('Failed to set font family');
      _updateStreamController(
        (await _userPreferencesStreamController.first)
            .copyWith(fontFamily: fontFamily),
      );
    } catch (e) {
      throw SetFontFamilyException(e.toString());
    }
  }

  @override
  Future<UserPreferenceFontFamily> getFontFamily() async {
    try {
      final fontFamilyString = _sharedPreferences.getString(_fontFamilyKey);
      if (fontFamilyString == null) {
        throw GetFontFamilyException('Failed to get font family');
      }
      return UserPreferenceFontFamily.values
          .firstWhere((e) => e.toString() == fontFamilyString);
    } catch (e) {
      throw GetFontFamilyException(e.toString());
    }
  }

  @override
  Future<void> setLanguage(UserPreferenceLanguage language) async {
    try {
      final success =
          await _sharedPreferences.setString(_languageKey, language.toString());
      if (!success) throw SetLanguageException('Failed to set language');
      _updateStreamController(
        (await _userPreferencesStreamController.first)
            .copyWith(language: language),
      );
    } catch (e) {
      throw SetLanguageException(e.toString());
    }
  }

  @override
  Future<UserPreferenceLanguage> getLanguage() async {
    try {
      final languageString = _sharedPreferences.getString(_languageKey);
      if (languageString == null) {
        return UserPreferenceLanguage.english;
      }
      return UserPreferenceLanguage.values
          .firstWhere((e) => e.toString() == languageString);
    } catch (e) {
      throw GetLanguageException(e.toString());
    }
  }

  @override
  Future<void> resetPreferences() async {
    try {
      await _sharedPreferences.clear();
      _updateStreamController(UserPreferences.defaults());
    } catch (e) {
      throw ResetPreferencesException('Failed to reset preferences: $e');
    }
  }

  @override
  Stream<UserPreferences> getAllPreferences() {
    return _userPreferencesStreamController.stream.asBroadcastStream();
  }

  /// Disposes the stream controller to free up resources.
  void dispose() {
    _userPreferencesStreamController.close();
  }
}
