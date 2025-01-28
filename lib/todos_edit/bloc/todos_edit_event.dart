part of 'todos_edit_bloc.dart';

abstract class TodosEditEvent extends Equatable {
  const TodosEditEvent();

  @override
  List<Object?> get props => [];
}

class TodosEditLoadTodo extends TodosEditEvent {
  const TodosEditLoadTodo(this.todo);
  
  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

class TodosEditTitleChanged extends TodosEditEvent {
  const TodosEditTitleChanged(this.title);
  
  final String title;

  @override
  List<Object> get props => [title];
}

class TodosEditDescriptionChanged extends TodosEditEvent {
  const TodosEditDescriptionChanged(this.description);
  
  final String description;

  @override
  List<Object> get props => [description];
}

class TodosEditSubmitted extends TodosEditEvent {}
