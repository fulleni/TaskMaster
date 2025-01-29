import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

part 'font_settings_event.dart';
part 'font_settings_state.dart';

/// Bloc that manages the state of font settings.
class FontSettingsBloc extends Bloc<FontSettingsEvent, FontSettingsState> {
  final UserPreferencesRepository _repository;

  /// Creates a [FontSettingsBloc] with the given [UserPreferencesRepository].
  FontSettingsBloc(this._repository) : super(const FontSettingsState()) {
    on<LoadFontSettings>(_onLoadFontSettings);
    on<UpdateTitleFontSize>(_onUpdateTitleFontSize);
    on<UpdateBodyFontSize>(_onUpdateBodyFontSize);
    on<UpdateFontFamily>(_onUpdateFontFamily);
  }

  Future<void> _onLoadFontSettings(
      LoadFontSettings event, Emitter<FontSettingsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final titleFontSize = await _repository.getTitleFontSize();
      final bodyFontSize = await _repository.getBodyFontSize();
      final fontFamily = await _repository.getFontFamily();
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
      await _repository.setTitleFontSize(event.fontSize);
      final titleFontSize = await _repository.getTitleFontSize();
      emit(state.copyWith(titleFontSize: titleFontSize));
    } catch (_) {
      emit(state.copyWith(hasError: true));
    }
  }

  Future<void> _onUpdateBodyFontSize(
      UpdateBodyFontSize event, Emitter<FontSettingsState> emit) async {
    try {
      await _repository.setBodyFontSize(event.fontSize);
      final bodyFontSize = await _repository.getBodyFontSize();
      emit(state.copyWith(bodyFontSize: bodyFontSize));
    } catch (_) {
      emit(state.copyWith(hasError: true));
    }
  }

  Future<void> _onUpdateFontFamily(
      UpdateFontFamily event, Emitter<FontSettingsState> emit) async {
    try {
      await _repository.setFontFamily(event.fontFamily);
      final fontFamily = await _repository.getFontFamily();
      emit(state.copyWith(fontFamily: fontFamily));
    } catch (_) {
      emit(state.copyWith(hasError: true));
    }
  }
}
