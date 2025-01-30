part of 'language_setting_bloc.dart';

sealed class LanguageSettingEvent extends Equatable {
  const LanguageSettingEvent();

  @override
  List<Object> get props => [];
}

class LoadLanguageSettings extends LanguageSettingEvent {}

class UpdateLanguage extends LanguageSettingEvent {
  final String language;

  const UpdateLanguage(this.language);

  @override
  List<Object> get props => [language];
}
