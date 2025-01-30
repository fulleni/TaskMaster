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
      fontSize: $enumDecode(_$UserPreferenceFontSizeEnumMap, json['fontSize']),
      fontFamily: $enumDecode(
          _$UserPreferenceGoogleFontsFamilyEnumMap, json['fontFamily']),
      language: $enumDecode(_$UserPreferenceLanguageEnumMap, json['language']),
    );

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'themeMode': _$UserPreferenceThemeModeEnumMap[instance.themeMode]!,
      'themeAccentColor':
          _$UserPreferenceAccentColorEnumMap[instance.themeAccentColor]!,
      'fontSize': _$UserPreferenceFontSizeEnumMap[instance.fontSize]!,
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
  UserPreferenceFontSize.defaultSize: 'defaultSize',
  UserPreferenceFontSize.mediumSize: 'mediumSize',
  UserPreferenceFontSize.largeSize: 'largeSize',
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
