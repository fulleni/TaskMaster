part of 'font_settings_bloc.dart';

/// Base class for all font settings events.
sealed class FontSettingsEvent extends Equatable {
  const FontSettingsEvent();

  @override
  List<Object> get props => [];
}

/// Event to load the current font settings.
final class LoadFontSettings extends FontSettingsEvent {}

/// Event to update the font size.
final class UpdateFontSize extends FontSettingsEvent {
  final UserPreferenceFontSize fontSize;

  /// Creates an [UpdateFontSize] event with the given [fontSize].
  const UpdateFontSize(this.fontSize);

  @override
  List<Object> get props => [fontSize];
}

/// Event to update the font family.
final class UpdateFontFamily extends FontSettingsEvent {
  final UserPreferenceFontFamily fontFamily;

  /// Creates an [UpdateFontFamily] event with the given [fontFamily].
  const UpdateFontFamily(this.fontFamily);

  @override
  List<Object> get props => [fontFamily];
}
