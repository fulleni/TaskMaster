import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserPreferencesRepository _userPreferencesRepository;

  AppBloc({required UserPreferencesRepository userPreferencesRepository})
      : _userPreferencesRepository = userPreferencesRepository,
        super(const AppState()) {
    on<AppLoaded>(_onAppLoaded);
  }

  Future<void> _onAppLoaded(
    AppLoaded event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.loading));
    await emit.forEach<UserPreferences>(
      _userPreferencesRepository.getAllPreferences(),
      onData: (preferences) => state.copyWith(
        status: AppStatus.loaded,
        userPreferences: preferences,
      ),
      onError: (error, stackTrace) =>
          state.copyWith(status: AppStatus.userPreferencesFailed),
    );
  }
}
