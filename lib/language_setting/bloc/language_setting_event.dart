part of 'language_setting_bloc.dart';

sealed class LanguageSettingEvent extends Equatable {
  const LanguageSettingEvent();

  @override
  List<Object> get props => [];
}

class LoadLanguageSettings extends LanguageSettingEvent {}

class UpdateLanguage extends LanguageSettingEvent {
  final String languageCode;

  const UpdateLanguage(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
