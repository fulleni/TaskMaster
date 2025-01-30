// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences(
      themeMode:
          $enumDecode(_$UserPreferenceThemeModeEnumMap, json['themeMode']),
      themeAccentColor: $enumDecode(
          _$UserPreferenceAccentColorEnumMap, json['themeAccentColor']),
      titleFontSize:
          $enumDecode(_$UserPreferenceFontSizeEnumMap, json['titleFontSize']),
      bodyFontSize:
          $enumDecode(_$UserPreferenceFontSizeEnumMap, json['bodyFontSize']),
      fontFamily: $enumDecode(
          _$UserPreferenceGoogleFontsFamilyEnumMap, json['fontFamily']),
      language: $enumDecode(_$UserPreferenceLanguageEnumMap, json['language']),
    );

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'themeMode': _$UserPreferenceThemeModeEnumMap[instance.themeMode]!,
      'themeAccentColor':
          _$UserPreferenceAccentColorEnumMap[instance.themeAccentColor]!,
      'titleFontSize': _$UserPreferenceFontSizeEnumMap[instance.titleFontSize]!,
      'bodyFontSize': _$UserPreferenceFontSizeEnumMap[instance.bodyFontSize]!,
      'fontFamily':
          _$UserPreferenceGoogleFontsFamilyEnumMap[instance.fontFamily]!,
      'language': _$UserPreferenceLanguageEnumMap[instance.language]!,
    };

const _$UserPreferenceThemeModeEnumMap = {
  UserPreferenceThemeMode.light: 'light',
  UserPreferenceThemeMode.dark: 'dark',
  UserPreferenceThemeMode.system: 'system',
};

const _$UserPreferenceAccentColorEnumMap = {
  UserPreferenceAccentColor.blue: 'blue',
  UserPreferenceAccentColor.grey: 'grey',
  UserPreferenceAccentColor.red: 'red',
};

const _$UserPreferenceFontSizeEnumMap = {
  UserPreferenceFontSize.small: 'small',
  UserPreferenceFontSize.medium: 'medium',
  UserPreferenceFontSize.large: 'large',
};

const _$UserPreferenceGoogleFontsFamilyEnumMap = {
  UserPreferenceGoogleFontsFamily.roboto: 'roboto',
  UserPreferenceGoogleFontsFamily.openSans: 'openSans',
  UserPreferenceGoogleFontsFamily.lato: 'lato',
  UserPreferenceGoogleFontsFamily.raleway: 'raleway',
  UserPreferenceGoogleFontsFamily.montserrat: 'montserrat',
  UserPreferenceGoogleFontsFamily.merriweather: 'merriweather',
  UserPreferenceGoogleFontsFamily.nunito: 'nunito',
  UserPreferenceGoogleFontsFamily.playfairDisplay: 'playfairDisplay',
  UserPreferenceGoogleFontsFamily.sourceSansPro: 'sourceSansPro',
  UserPreferenceGoogleFontsFamily.ubuntu: 'ubuntu',
};

const _$UserPreferenceLanguageEnumMap = {
  UserPreferenceLanguage.english: 'english',
  UserPreferenceLanguage.arabic: 'arabic',
};
