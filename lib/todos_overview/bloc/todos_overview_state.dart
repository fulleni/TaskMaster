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
  });

  /// The list of todos.
  final List<Todo> todos;

  /// The status of the todos overview.
  final TodosOverviewStatus status;

  /// The last deleted todo.
  final Todo? lastDeletedTodo;

  /// Creates a copy of this state with the specified fields replaced with new values.
  TodosOverviewState copyWith({
    List<Todo>? todos,
    TodosOverviewStatus? status,
    Todo? lastDeletedTodo,
  }) {
    return TodosOverviewState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
      lastDeletedTodo: lastDeletedTodo ?? this.lastDeletedTodo,
    );
  }

  @override
  List<Object?> get props => [todos, status, lastDeletedTodo];
}

/// The status of the todos overview.
enum TodosOverviewStatus { initial, loading, success, failure }
