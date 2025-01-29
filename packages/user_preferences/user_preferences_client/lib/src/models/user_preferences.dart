import 'package:json_annotation/json_annotation.dart';
import 'package:user_preferences_client/src/user_preferences_client.dart';
part 'user_preferences.g.dart';

/// Model representing all user preferences.
@JsonSerializable()
class UserPreferences {
  final UserPreferenceThemeMode themeMode;
  final UserPreferenceAccentColor themeAccentColor;
  final UserPreferenceFontSize titleFontSize;
  final UserPreferenceFontSize bodyFontSize;
  final UserPreferenceGoogleFontsFamily fontFamily;
  final UserPreferenceLanguage language;

  UserPreferences({
    required this.themeMode,
    required this.themeAccentColor,
    required this.titleFontSize,
    required this.bodyFontSize,
    required this.fontFamily,
    required this.language,
  });

  /// Resets all preferences to their default values.
  UserPreferences resetToDefaults() {
    return UserPreferences(
      themeMode: UserPreferenceThemeMode.system,
      themeAccentColor: UserPreferenceAccentColor.accentOne,
      titleFontSize: UserPreferenceFontSize.medium,
      bodyFontSize: UserPreferenceFontSize.medium,
      fontFamily: UserPreferenceGoogleFontsFamily.roboto,
      language: UserPreferenceLanguage.english,
    );
  }

  /// Updates individual preferences.
  UserPreferences copyWith({
    UserPreferenceThemeMode? themeMode,
    UserPreferenceAccentColor? themeAccentColor,
    UserPreferenceFontSize? titleFontSize,
    UserPreferenceFontSize? bodyFontSize,
    UserPreferenceGoogleFontsFamily? fontFamily,
    UserPreferenceLanguage? language,
  }) {
    return UserPreferences(
      themeMode: themeMode ?? this.themeMode,
      themeAccentColor: themeAccentColor ?? this.themeAccentColor,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      bodyFontSize: bodyFontSize ?? this.bodyFontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      language: language ?? this.language,
    );
  }

  /// Compares two `UserPreferences` instances.
  bool isEqual(UserPreferences other) {
    return themeMode == other.themeMode &&
        themeAccentColor == other.themeAccentColor &&
        titleFontSize == other.titleFontSize &&
        bodyFontSize == other.bodyFontSize &&
        fontFamily == other.fontFamily &&
        language == other.language;
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);
}
