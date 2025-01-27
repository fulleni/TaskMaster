part of 'todos_overview_bloc.dart';

sealed class TodosOverviewEvent extends Equatable {
  const TodosOverviewEvent();

  @override
  List<Object> get props => [];
}

/// Event to load all todos.
final class TodosOverviewLoadTodos extends TodosOverviewEvent {}

/// Event to delete a todo.
final class TodosOverviewDeleteTodo extends TodosOverviewEvent {
  const TodosOverviewDeleteTodo(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

/// Event to undelete a just deleted todo.
final class TodosOverviewUndoDelete extends TodosOverviewEvent {
  const TodosOverviewUndoDelete();
}

/// Event to toggle the completion status of a single todo.
final class TodosOverviewToggleTodoCompleted extends TodosOverviewEvent {
  const TodosOverviewToggleTodoCompleted(this.id, this.isCompleted);

  final String id;
  final bool isCompleted;

  @override
  List<Object> get props => [id, isCompleted];
}

/// Event to toggle the completion status of all todos.
final class TodosOverviewToggleCompleteAll extends TodosOverviewEvent {
  const TodosOverviewToggleCompleteAll(this.isCompleted);

  final bool isCompleted;

  @override
  List<Object> get props => [isCompleted];
}

/// Event to clear all completed todos.
final class TodosOverviewClearCompleted extends TodosOverviewEvent {}

/// Event to delete all completed todos.
final class TodosOverviewDeleteAllCompleted extends TodosOverviewEvent {}