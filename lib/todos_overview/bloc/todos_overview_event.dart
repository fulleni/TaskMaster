part of 'todos_overview_bloc.dart';

/// Base class for all todos overview events
sealed class TodosOverviewEvent extends Equatable {
  const TodosOverviewEvent();

  @override
  List<Object> get props => [];
}

/// Mission: Load and display all todos from the repository
///
/// Triggers the initial load of todos when the overview page is opened
final class TodosOverviewLoadTodos extends TodosOverviewEvent {}

/// Mission: Delete a specific todo by its ID
///
/// When a todo is deleted, it is stored temporarily to enable undo functionality
final class TodosOverviewDeleteTodo extends TodosOverviewEvent {
  const TodosOverviewDeleteTodo(this.id);

  /// The unique identifier of the todo to be deleted
  final String id;

  @override
  List<Object> get props => [id];
}

/// Mission: Restore the last deleted todo
///
/// Retrieves the temporarily stored deleted todo and saves it back to the repository
final class TodosOverviewUndoDelete extends TodosOverviewEvent {
  const TodosOverviewUndoDelete();
}

/// Mission: Toggle completion status of a specific todo
///
/// Changes the isCompleted flag of a todo identified by its ID
final class TodosOverviewToggleTodoCompleted extends TodosOverviewEvent {
  const TodosOverviewToggleTodoCompleted(this.id, this.isCompleted);

  /// The unique identifier of the todo to toggle
  final String id;

  /// The new completion status to set
  final bool isCompleted;

  @override
  List<Object> get props => [id, isCompleted];
}

/// Mission: Toggle completion status of all todos
///
/// Sets all todos to either completed or uncompleted based on the input flag
final class TodosOverviewToggleCompleteAll extends TodosOverviewEvent {
  const TodosOverviewToggleCompleteAll(this.isCompleted);

  /// The completion status to set for all todos
  final bool isCompleted;

  @override
  List<Object> get props => [isCompleted];
}

/// Mission: Delete all completed todos
///
/// Removes all todos that have their isCompleted flag set to true
final class TodosOverviewDeleteCompleted extends TodosOverviewEvent {}

/// Mission: Apply a filter to the todos list
///
/// Filters todos based on their completion status: all, completed only, or uncompleted only
final class TodosOverviewFilterTodos extends TodosOverviewEvent {
  const TodosOverviewFilterTodos(this.filter);

  /// The filter to apply to the todos list
  final TodosOverviewFilter filter;

  @override
  List<Object> get props => [filter];
}


/// Mission: Revert the last todo update
///
/// Restores the todo to its state before the last update
final class TodosOverviewUndoUpdate extends TodosOverviewEvent {
  const TodosOverviewUndoUpdate({
    required this.initialTodo,
  });

  /// the todo before it was updated, 
  /// it will be used to override the updated todo.
  final Todo initialTodo;


  @override
  List<Object> get props => [initialTodo];
}
