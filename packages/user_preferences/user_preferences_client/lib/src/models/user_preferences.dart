import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_preferences_client/src/user_preferences_client.dart';
part 'user_preferences.g.dart';

/// Model representing all user preferences.
@JsonSerializable()
class UserPreferences extends Equatable {
  final UserPreferenceThemeMode themeMode;
  final UserPreferenceAccentColor themeAccentColor;
  final UserPreferenceFontSize fontSize;
  final UserPreferenceFontFamily fontFamily;
  final UserPreferenceLanguage language;

  UserPreferences({
    required this.themeMode,
    required this.themeAccentColor,
    required this.fontSize,
    required this.fontFamily,
    required this.language,
  });

  UserPreferences.defaults()
      : themeMode = UserPreferenceThemeMode.system,
        themeAccentColor = UserPreferenceAccentColor.red,
        fontSize = UserPreferenceFontSize.defaultSize,
        fontFamily = UserPreferenceFontFamily.ubuntu,
        language = UserPreferenceLanguage.english;

  /// Resets all preferences to their default values.
  UserPreferences resetToDefaults() {
    return UserPreferences(
      themeMode: UserPreferenceThemeMode.system,
      themeAccentColor: UserPreferenceAccentColor.red,
      fontSize: UserPreferenceFontSize.defaultSize,
      fontFamily: UserPreferenceFontFamily.ubuntu,
      language: UserPreferenceLanguage.english,
    );
  }

  /// Updates individual preferences.
  UserPreferences copyWith({
    UserPreferenceThemeMode? themeMode,
    UserPreferenceAccentColor? themeAccentColor,
    UserPreferenceFontSize? fontSize,
    UserPreferenceFontFamily? fontFamily,
    UserPreferenceLanguage? language,
  }) {
    return UserPreferences(
      themeMode: themeMode ?? this.themeMode,
      themeAccentColor: themeAccentColor ?? this.themeAccentColor,
      fontSize: fontSize ?? this.fontSize,
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
        fontSize,
        fontFamily,
        language,
      ];
}
