part of 'todos_overview_bloc.dart';

/// {@template todos_overview_state}
/// Represents the state of the todos overview.
/// {@endtemplate}
final class TodosOverviewState extends Equatable {
  /// {@macro todos_overview_state}
  const TodosOverviewState({
    this.todos = const [],
    this.status = TodosOverviewStatus.initial,
    this.lastDeletedTodo,
    this.filter = TodosOverviewFilter.all,
  });

  /// The list of todos.
  final List<Todo> todos;

  /// The status of the todos overview.
  final TodosOverviewStatus status;

  /// The last deleted todo.
  final Todo? lastDeletedTodo;

  /// The current filter applied to the todos.
  final TodosOverviewFilter filter;

  /// Creates a copy of this state with the specified fields replaced with new values.
  TodosOverviewState copyWith({
    List<Todo>? todos,
    TodosOverviewStatus? status,
    Todo? lastDeletedTodo,
    TodosOverviewFilter? filter,
  }) {
    return TodosOverviewState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
      lastDeletedTodo: lastDeletedTodo ?? this.lastDeletedTodo,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [todos, status, lastDeletedTodo, filter];
}

/// The status of the todos overview.
enum TodosOverviewStatus { initial, loading, success, failure }

/// The filter options for the todos overview.
enum TodosOverviewFilter { all, completedOnly, uncompletedOnly }
