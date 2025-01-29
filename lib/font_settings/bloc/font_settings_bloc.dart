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
    on<UpdateTitleFontSize>(_onUpdateTitleFontSize);
    on<UpdateBodyFontSize>(_onUpdateBodyFontSize);
    on<UpdateFontFamily>(_onUpdateFontFamily);
  }

  Future<void> _onLoadFontSettings(
      LoadFontSettings event, Emitter<FontSettingsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final titleFontSize = await _userPreferencesRepository.getTitleFontSize();
      final bodyFontSize = await _userPreferencesRepository.getBodyFontSize();
      final fontFamily = await _userPreferencesRepository.getFontFamily();
      emit(state.copyWith(
        titleFontSize: titleFontSize,
        bodyFontSize: bodyFontSize,
        fontFamily: fontFamily,
        isLoading: false,
      ));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

  Future<void> _onUpdateTitleFontSize(
      UpdateTitleFontSize event, Emitter<FontSettingsState> emit) async {
    try {
      await _userPreferencesRepository.setTitleFontSize(event.fontSize);
      final titleFontSize = await _userPreferencesRepository.getTitleFontSize();
      emit(state.copyWith(titleFontSize: titleFontSize));
    } catch (_) {
      emit(state.copyWith(hasError: true));
    }
  }

  Future<void> _onUpdateBodyFontSize(
      UpdateBodyFontSize event, Emitter<FontSettingsState> emit) async {
    try {
      await _userPreferencesRepository.setBodyFontSize(event.fontSize);
      final bodyFontSize = await _userPreferencesRepository.getBodyFontSize();
      emit(state.copyWith(bodyFontSize: bodyFontSize));
    } catch (_) {
      emit(state.copyWith(hasError: true));
    }
  }

  Future<void> _onUpdateFontFamily(
      UpdateFontFamily event, Emitter<FontSettingsState> emit) async {
    try {
      await _userPreferencesRepository.setFontFamily(event.fontFamily);
      final fontFamily = await _userPreferencesRepository.getFontFamily();
      emit(state.copyWith(fontFamily: fontFamily));
    } catch (_) {
      emit(state.copyWith(hasError: true));
    }
  }
}
