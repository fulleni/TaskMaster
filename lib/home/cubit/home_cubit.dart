import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

/// {@template home_cubit}
/// A cubit that manages the state of the home screen.
/// {@endtemplate}
class HomeCubit extends Cubit<HomeState> {
  /// {@macro home_cubit}
  HomeCubit() : super(HomeState(selectedTab: HomeTab.todos));

  /// Sets the state with a new tab.
  ///
  /// [tab] The new tab to be set.
  void setTab(HomeTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}


