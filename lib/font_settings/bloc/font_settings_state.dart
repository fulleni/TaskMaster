part of 'font_settings_bloc.dart';

/// Represents the state of font settings in the application.
class FontSettingsState extends Equatable {
  /// The font size for titles.
  final UserPreferenceFontSize? titleFontSize;

  /// The font size for body text.
  final UserPreferenceFontSize? bodyFontSize;

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
    this.titleFontSize,
    this.bodyFontSize,
    this.fontFamily,
    this.isLoading = false,
    this.hasError = false,
  });

  /// Creates a copy of the current state with the given parameters.
  ///
  /// Any parameter that is not provided will default to the current value.
  FontSettingsState copyWith({
    UserPreferenceFontSize? titleFontSize,
    UserPreferenceFontSize? bodyFontSize,
    UserPreferenceGoogleFontsFamily? fontFamily,
    bool? isLoading,
    bool? hasError,
  }) {
    return FontSettingsState(
      titleFontSize: titleFontSize ?? this.titleFontSize,
      bodyFontSize: bodyFontSize ?? this.bodyFontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object?> get props => [
        titleFontSize,
        bodyFontSize,
        fontFamily,
        isLoading,
        hasError,
      ];
}
