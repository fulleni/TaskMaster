part of 'font_settings_bloc.dart';

enum FontSettingsStatus {
  initial,
  loading,
  success,
  failure,
}

/// Represents the state of font settings in the application.
class FontSettingsState extends Equatable {
  /// The font size .
  final UserPreferenceFontSize? fontSize;

  /// The font family.
  final UserPreferenceFontFamily? fontFamily;

  /// The status of the font settings.
  final FontSettingsStatus status;

  /// Creates a new [FontSettingsState].
  ///
  /// All parameters are optional and default to `null` or `FontSettingsStatus.initial`.
  const FontSettingsState({
    this.fontSize,
    this.fontFamily,
    this.status = FontSettingsStatus.initial,
  });

  /// Creates a copy of the current state with the given parameters.
  ///
  /// Any parameter that is not provided will default to the current value.
  FontSettingsState copyWith({
    UserPreferenceFontSize? fontSize,
    UserPreferenceFontFamily? fontFamily,
    FontSettingsStatus? status,
  }) {
    return FontSettingsState(
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        fontSize,
        fontFamily,
        status,
      ];
}
