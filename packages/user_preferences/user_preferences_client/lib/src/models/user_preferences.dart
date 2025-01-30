import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_preferences_client/src/user_preferences_client.dart';
part 'user_preferences.g.dart';

/// Model representing all user preferences.
@JsonSerializable()
class UserPreferences extends Equatable {
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

  UserPreferences.defaults()
      : themeMode = UserPreferenceThemeMode.system,
        themeAccentColor = UserPreferenceAccentColor.grey,
        titleFontSize = UserPreferenceFontSize.medium,
        bodyFontSize = UserPreferenceFontSize.medium,
        fontFamily = UserPreferenceGoogleFontsFamily.roboto,
        language = UserPreferenceLanguage.english;

  /// Resets all preferences to their default values.
  UserPreferences resetToDefaults() {
    return UserPreferences(
      themeMode: UserPreferenceThemeMode.system,
      themeAccentColor: UserPreferenceAccentColor.blue,
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

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);

  @override
  List<Object?> get props => [
        themeMode,
        themeAccentColor,
        titleFontSize,
        bodyFontSize,
        fontFamily,
        language,
      ];
}
