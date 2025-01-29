part of 'theme_settings_bloc.dart';

/// Base class for all theme settings events.
sealed class ThemeSettingsEvent extends Equatable {
  /// Creates a [ThemeSettingsEvent].
  const ThemeSettingsEvent();

  @override
  List<Object> get props => [];
}

/// Event to load the current theme settings.
final class LoadThemeSettings extends ThemeSettingsEvent {
  /// Creates a [LoadThemeSettings] event.
  const LoadThemeSettings();
}

/// Event to update the theme mode.
final class UpdateThemeMode extends ThemeSettingsEvent {
  final UserPreferenceThemeMode themeMode;

  /// Creates an [UpdateThemeMode] event with the given [themeMode].
  const UpdateThemeMode(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

/// Event to update the theme accent color.
final class UpdateThemeAccentColor extends ThemeSettingsEvent {
  final UserPreferenceAccentColor accentColor;

  /// Creates an [UpdateThemeAccentColor] event with the given [accentColor].
  const UpdateThemeAccentColor(this.accentColor);

  @override
  List<Object> get props => [accentColor];
}
