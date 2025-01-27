part of 'todos_stats_bloc.dart';

sealed class TodosStatsEvent extends Equatable {
  const TodosStatsEvent();

  @override
  List<Object> get props => [];
}

/// Event to load the todos stats.
final class TodosStatsLoad extends TodosStatsEvent {}
