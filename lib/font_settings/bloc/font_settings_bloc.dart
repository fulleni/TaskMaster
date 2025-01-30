import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

part 'font_settings_event.dart';
part 'font_settings_state.dart';

/// Bloc that manages the state of font settings.
class FontSettingsBloc extends Bloc<FontSettingsEvent, FontSettingsState> {
  final UserPreferencesRepository _userPreferencesRepository;

  /// Creates a [FontSettingsBloc] with the given [UserPreferencesRepository].
  FontSettingsBloc({
    required UserPreferencesRepository userPreferencesRepository,
  })  : _userPreferencesRepository = userPreferencesRepository,
        super(const FontSettingsState()) {
    on<LoadFontSettings>(_onLoadFontSettings);
    on<UpdateFontSize>(_onUpdateFontSize);
    on<UpdateFontFamily>(_onUpdateFontFamily);
  }

  Future<void> _onLoadFontSettings(
      LoadFontSettings event, Emitter<FontSettingsState> emit) async {
    emit(state.copyWith(status: FontSettingsStatus.loading));
    try {
      await emit.forEach<UserPreferences>(
        _userPreferencesRepository.getAllPreferences(),
        onData: (preferences) => state.copyWith(
          fontSize: preferences.fontSize,
          fontFamily: preferences.fontFamily,
          status: FontSettingsStatus.success,
        ),
        onError: (_, __) =>
            state.copyWith(status: FontSettingsStatus.failure),
      );
    } catch (_) {
      emit(state.copyWith(status: FontSettingsStatus.failure));
    }
  }

  Future<void> _onUpdateFontSize(
      UpdateFontSize event, Emitter<FontSettingsState> emit) async {
    try {
      await _userPreferencesRepository.setFontSize(event.fontSize);
      final fontSize = await _userPreferencesRepository.getFontSize();
      emit(state.copyWith(
        fontSize: fontSize,
        status: FontSettingsStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: FontSettingsStatus.failure));
    }
  }

  Future<void> _onUpdateFontFamily(
      UpdateFontFamily event, Emitter<FontSettingsState> emit) async {
    try {
      await _userPreferencesRepository.setFontFamily(event.fontFamily);
      final fontFamily = await _userPreferencesRepository.getFontFamily();
      emit(state.copyWith(
        fontFamily: fontFamily,
        status: FontSettingsStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: FontSettingsStatus.failure));
    }
  }
}
