part of 'language_setting_bloc.dart';

enum Status {
  initial,
  loading,
  success,
  failure
}

class LanguageSettingState extends Equatable {
  final String language;
  final Status status;
  final String? errorMessage;

  const LanguageSettingState({
    this.language = 'english',
    this.status = Status.initial,
    this.errorMessage,
  });

  LanguageSettingState copyWith({
    String? language,
    Status? status,
    String? errorMessage,
  }) {
    return LanguageSettingState(
      language: language ?? this.language,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [language, status, errorMessage];
}
