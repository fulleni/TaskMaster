part of 'theme_settings_bloc.dart';

/// Represents the state of theme settings in the application.
class ThemeSettingsState extends Equatable {
  final UserPreferenceThemeMode? themeMode;
  final UserPreferenceAccentColor? accentColor;
  final bool isLoading;
  final bool hasError;

  /// Creates a new [ThemeSettingsState].
  ///
  /// All parameters are optional and default to `null` or `false`.
  const ThemeSettingsState({
    this.themeMode,
    this.accentColor,
    this.isLoading = false,
    this.hasError = false,
  });

  /// Creates a copy of the current state with the given parameters.
  ///
  /// Any parameter that is not provided will default to the current value.
  ThemeSettingsState copyWith({
    UserPreferenceThemeMode? themeMode,
    UserPreferenceAccentColor? accentColor,
    bool? isLoading,
    bool? hasError,
  }) {
    return ThemeSettingsState(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        accentColor,
        isLoading,
        hasError,
      ];
}
