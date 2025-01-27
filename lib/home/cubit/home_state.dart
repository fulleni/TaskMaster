part of 'home_cubit.dart';

/// Defines the available tabs in the home screen
enum HomeTab { todos, stats }

/// {@template home_state}
/// Represents the state of the home screen.
/// Manages the currently selected tab.
/// {@endtemplate}
final class HomeState extends Equatable {
  /// {@macro home_state}
  const HomeState({
    required this.selectedTab,
  });

  /// The currently active tab in the home screen
  final HomeTab selectedTab;

  /// Creates a copy of this state with the specified fields replaced with new values
  /// 
  /// If [selectedTab] is null, the current value is retained
  HomeState copyWith({HomeTab? selectedTab}) {
    return HomeState(selectedTab: selectedTab ?? this.selectedTab);
  }

  @override
  String toString() => 'HomeState{selectedTab: $selectedTab}';

  @override
  List<Object?> get props => [selectedTab];
}