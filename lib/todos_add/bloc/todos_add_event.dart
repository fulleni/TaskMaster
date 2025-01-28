part of 'todos_add_bloc.dart';

abstract class TodosAddEvent extends Equatable {
  const TodosAddEvent();

  @override
  List<Object> get props => [];
}

class TodosAddTitleChanged extends TodosAddEvent {
  const TodosAddTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class TodosAddDescriptionChanged extends TodosAddEvent {
  const TodosAddDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class TodosAddSubmitted extends TodosAddEvent {
  const TodosAddSubmitted();
}
