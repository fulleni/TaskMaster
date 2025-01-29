part of 'app_bloc.dart';

enum AppStatus { initial, loading, loaded, userPreferencesFailed }

class AppState extends Equatable {
  final AppStatus status;
  final UserPreferences? userPreferences;

  const AppState({
    this.status = AppStatus.initial,
    this.userPreferences,
  });

  AppState copyWith({
    AppStatus? status,
    UserPreferences? userPreferences,
  }) {
    return AppState(
      status: status ?? this.status,
      userPreferences: userPreferences ?? this.userPreferences,
    );
  }

  @override
  List<Object?> get props => [status, userPreferences];
}
