import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

part 'theme_settings_event.dart';
part 'theme_settings_state.dart';

/// Bloc that manages the state of theme settings.
class ThemeSettingsBloc extends Bloc<ThemeSettingsEvent, ThemeSettingsState> {
  final UserPreferencesRepository _repository;

  /// Creates a [ThemeSettingsBloc] with the given [UserPreferencesRepository].
  ThemeSettingsBloc(this._repository) : super(const ThemeSettingsState()) {
    on<LoadThemeSettings>(_onLoadThemeSettings);
    on<UpdateThemeMode>(_onUpdateThemeMode);
    on<UpdateThemeAccentColor>(_onUpdateThemeAccentColor);
  }

  /// Handles the [LoadThemeSettings] event.
  ///
  /// Loads the current theme settings from the repository and updates the state.
  Future<void> _onLoadThemeSettings(
      LoadThemeSettings event, Emitter<ThemeSettingsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final themeMode = await _repository.getThemeMode();
      final accentColor = await _repository.getThemeAccentColor();
      emit(state.copyWith(
        themeMode: themeMode,
        accentColor: accentColor,
        isLoading: false,
      ));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

  /// Handles the [UpdateThemeMode] event.
  ///
  /// Updates the theme mode in the repository and updates the state.
  Future<void> _onUpdateThemeMode(
      UpdateThemeMode event, Emitter<ThemeSettingsState> emit) async {
    try {
      await _repository.setThemeMode(event.themeMode);
      final themeMode = await _repository.getThemeMode();
      emit(state.copyWith(themeMode: themeMode));
    } catch (_) {
      emit(state.copyWith(hasError: true));
    }
  }

  /// Handles the [UpdateThemeAccentColor] event.
  ///
  /// Updates the theme accent color in the repository and updates the state.
  Future<void> _onUpdateThemeAccentColor(
      UpdateThemeAccentColor event, Emitter<ThemeSettingsState> emit) async {
    try {
      await _repository.setThemeAccentColor(event.accentColor);
      final accentColor = await _repository.getThemeAccentColor();
      emit(state.copyWith(accentColor: accentColor));
    } catch (_) {
      emit(state.copyWith(hasError: true));
    }
  }
}
