part of 'language_setting_bloc.dart';

class LanguageSettingState extends Equatable {
  final String language;
  final bool isLoading;
  final String? error;

  const LanguageSettingState({
    this.language = 'english',
    this.isLoading = false,
    this.error,
  });

  LanguageSettingState copyWith({
    String? language,
    bool? isLoading,
    String? error,
  }) {
    return LanguageSettingState(
      language: language ?? this.language,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [language, isLoading, error];
}
