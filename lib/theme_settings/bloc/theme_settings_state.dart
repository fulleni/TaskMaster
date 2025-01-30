part of 'theme_settings_bloc.dart';

enum ThemeSettingsStatus { initial, loading, success, failure }

/// Represents the state of theme settings in the application.
class ThemeSettingsState extends Equatable {
  final UserPreferenceThemeMode? themeMode;
  final UserPreferenceAccentColor? accentColor;
  final ThemeSettingsStatus status;

  /// Creates a new [ThemeSettingsState].
  const ThemeSettingsState({
    this.themeMode,
    this.accentColor,
    this.status = ThemeSettingsStatus.initial,
  });

  /// Creates a copy of the current state with the given parameters.
  ThemeSettingsState copyWith({
    UserPreferenceThemeMode? themeMode,
    UserPreferenceAccentColor? accentColor,
    ThemeSettingsStatus? status,
  }) {
    return ThemeSettingsState(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [themeMode, accentColor, status];
}
