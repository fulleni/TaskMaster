part of 'todos_add_bloc.dart';

enum TodosAddStatus { initial, loading, success, failure }

class TodosAddState extends Equatable {
  const TodosAddState({
    this.status = TodosAddStatus.initial,
    this.title = '',
    this.description = '',
    this.todo,
    this.isValid = false,
    this.isDirty = false,
  });

  final TodosAddStatus status;
  final String title;
  final String description;
  final Todo? todo;
  final bool isValid;
  final bool isDirty;  // New field to track if user has started typing

  TodosAddState copyWith({
    TodosAddStatus? status,
    String? title,
    String? description,
    Todo? todo,
    bool? isValid,
    bool? isDirty,
  }) {
    return TodosAddState(
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      todo: todo ?? this.todo,
      isValid: isValid ?? this.isValid,
      isDirty: isDirty ?? this.isDirty,
    );
  }

  @override
  List<Object?> get props => [status, title, description, todo, isValid, isDirty];
}
