import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

part 'language_setting_event.dart';
part 'language_setting_state.dart';

class LanguageSettingBloc
    extends Bloc<LanguageSettingEvent, LanguageSettingState> {
  final UserPreferencesRepository _userPreferencesRepository;

  LanguageSettingBloc({
    required UserPreferencesRepository userPreferencesRepository,
  })  : _userPreferencesRepository = userPreferencesRepository,
        super(const LanguageSettingState()) {
    on<LoadLanguageSettings>(_onLoadLanguageSettings);
    on<UpdateLanguage>(_onUpdateLanguage);
  }

  Future<void> _onLoadLanguageSettings(
    LoadLanguageSettings event,
    Emitter<LanguageSettingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final languageEnum = await _userPreferencesRepository.getLanguage();

      print(languageEnum);

      final languasgeStringified = languageEnum.toLanguage;
      print(languasgeStringified);

      emit(state.copyWith(
        language: languageEnum.toLanguage,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'e.toString()',
        isLoading: false,
      ));
    }
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguage event,
    Emitter<LanguageSettingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _userPreferencesRepository
          .setLanguage(event.language.toUserPreferenceLanguage);
      emit(state.copyWith(language: event.language, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }
}

extension StringX on String {
  UserPreferenceLanguage get toUserPreferenceLanguage {
    switch (this) {
      case 'english':
        return UserPreferenceLanguage.english;
      case 'arabic':
        return UserPreferenceLanguage.arabic;
      default:
        return UserPreferenceLanguage.english;
    }
  }
}

extension UserPreferenceLanguageX on UserPreferenceLanguage {
  String get toLanguage {
    switch (this) {
      case UserPreferenceLanguage.english:
        return 'english';
      case UserPreferenceLanguage.arabic:
        return 'arabic';
    }
  }
}
