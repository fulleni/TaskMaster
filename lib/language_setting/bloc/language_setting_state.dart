part of 'language_setting_bloc.dart';

class LanguageSettingState extends Equatable {
  final String languageCode;
  final bool isLoading;
  final String? error;

  const LanguageSettingState({
    this.languageCode = 'en',
    this.isLoading = false,
    this.error,
  });

  LanguageSettingState copyWith({
    String? languageCode,
    bool? isLoading,
    String? error,
  }) {
    return LanguageSettingState(
      languageCode: languageCode ?? this.languageCode,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [languageCode, isLoading, error];
}
