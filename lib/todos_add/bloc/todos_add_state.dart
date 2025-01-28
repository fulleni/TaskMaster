part of 'todos_add_bloc.dart';

enum TodosAddStatus { initial, loading, success, failure }

class TodosAddState extends Equatable {
  const TodosAddState({
    this.status = TodosAddStatus.initial,
    this.title = '',
    this.description = '',
    this.todo,
  });

  final TodosAddStatus status;
  final String title;
  final String description;
  final Todo? todo;

  TodosAddState copyWith({
    TodosAddStatus? status,
    String? title,
    String? description,
    Todo? todo,
  }) {
    return TodosAddState(
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      todo: todo ?? this.todo,
    );
  }

  @override
  List<Object?> get props => [status, title, description, todo];
}
