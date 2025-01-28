part of 'todos_edit_bloc.dart';

/// Status of the todo editing operation
enum TodosEditStatus {
  /// Initial state when the edit page is loaded
  initial,

  /// State while saving changes
  loading,

  /// State when changes were saved successfully
  success,

  /// State when saving changes failed
  failure
}

/// {@template todos_edit_state}
/// Represents the state of the todo editing form.
/// Includes the current status, initial todo data, and edited values.
/// {@endtemplate}
class TodosEditState extends Equatable {
  /// {@macro todos_edit_state}
  const TodosEditState({
    this.status = TodosEditStatus.initial,
    this.todo,
    this.title = '',
    this.description = '',
  });

  /// Current status of the editing operation
  final TodosEditStatus status;

  /// The original todo being edited, used as reference
  final Todo? todo;

  /// The current value of the title field
  final String title;

  /// The current value of the description field
  final String description;

  /// Creates a copy of this state with the given fields replaced with new values
  TodosEditState copyWith({
    TodosEditStatus? status,
    Todo? todo,
    String? title,
    String? description,
  }) {
    return TodosEditState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, todo, title, description];
}
