part of 'todos_stats_bloc.dart';

class TodosStatsState extends Equatable {
  const TodosStatsState({
    this.numCompleted = 0,
    this.numActive = 0,
    this.status = TodosStatsStatus.initial,
  });

  final int numCompleted;
  final int numActive;
  final TodosStatsStatus status;

  TodosStatsState copyWith({
    int? numCompleted,
    int? numActive,
    TodosStatsStatus? status,
  }) {
    return TodosStatsState(
      numCompleted: numCompleted ?? this.numCompleted,
      numActive: numActive ?? this.numActive,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [numCompleted, numActive, status];
}

enum TodosStatsStatus { initial, loading, success, failure }