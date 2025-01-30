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
    emit(state.copyWith(status: Status.loading));
    try {
      final languageEnum = await _userPreferencesRepository.getLanguage();
      emit(state.copyWith(
        language: languageEnum.toLanguage,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: Status.failure,
      ));
    }
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguage event,
    Emitter<LanguageSettingState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _userPreferencesRepository
          .setLanguage(event.language.toUserPreferenceLanguage);
      emit(state.copyWith(
        language: event.language,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: Status.failure,
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
