part of 'font_settings_bloc.dart';

/// Represents the state of font settings in the application.
class FontSettingsState extends Equatable {
  /// The font size .
  final UserPreferenceFontSize? fontSize;

  /// The font family.
  final UserPreferenceGoogleFontsFamily? fontFamily;

  /// Indicates whether the state is currently loading.
  final bool isLoading;

  /// Indicates whether there was an error.
  final bool hasError;

  /// Creates a new [FontSettingsState].
  ///
  /// All parameters are optional and default to `null` or `false`.
  const FontSettingsState({
    this.fontSize,
    this.fontFamily,
    this.isLoading = false,
    this.hasError = false,
  });

  /// Creates a copy of the current state with the given parameters.
  ///
  /// Any parameter that is not provided will default to the current value.
  FontSettingsState copyWith({
    UserPreferenceFontSize? fontSize,
    UserPreferenceGoogleFontsFamily? fontFamily,
    bool? isLoading,
    bool? hasError,
  }) {
    return FontSettingsState(
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object?> get props => [
        fontSize,
        fontFamily,
        isLoading,
        hasError,
      ];
}
