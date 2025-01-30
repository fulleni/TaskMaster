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
      final language = await _userPreferencesRepository.getLanguage();
      emit(state.copyWith(
        languageCode: language.toLanguageCode,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
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
      await emit.forEach<UserPreferences>(
        _userPreferencesRepository.getAllPreferences(),
        onData: (preferences) => state.copyWith(
          languageCode: preferences.language.toLanguageCode,
          isLoading: false,
        ),
        onError: (e, __) =>
            state.copyWith(isLoading: false, error: e.toString()),
      );
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
      case 'en':
        return UserPreferenceLanguage.english;
      case 'ar':
        return UserPreferenceLanguage.arabic;
      default:
        return UserPreferenceLanguage.english;
    }
  }
}

extension UserPreferenceLanguageX on UserPreferenceLanguage {
  String get toLanguageCode {
    switch (this) {
      case UserPreferenceLanguage.english:
        return 'en';
      case UserPreferenceLanguage.arabic:
        return 'ar';
    }
  }
}
