import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_add_event.dart';
part 'todos_add_state.dart';

class TodosAddBloc extends Bloc<TodosAddEvent, TodosAddState> {
  TodosAddBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const TodosAddState()) {
    on<TodosAddTitleChanged>(_onTitleChanged);
    on<TodosAddDescriptionChanged>(_onDescriptionChanged);
    on<TodosAddSubmitted>(_onSubmitted);
  }

  final TodosRepository _todosRepository;

  void _onTitleChanged(
    TodosAddTitleChanged event,
    Emitter<TodosAddState> emit,
  ) {
    final title = event.title.trim();
    emit(state.copyWith(
      title: title,
      isValid: title.isNotEmpty,
    ));
  }

  void _onDescriptionChanged(
    TodosAddDescriptionChanged event,
    Emitter<TodosAddState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
    TodosAddSubmitted event,
    Emitter<TodosAddState> emit,
  ) async {
    emit(state.copyWith(status: TodosAddStatus.loading));

    try {
      if (state.title.isEmpty) {
        throw ArgumentError('Title cannot be empty');
      }

      final todo = Todo(
        title: state.title,
        description: state.description,
      );

      await _todosRepository.saveTodo(todo);
      emit(state.copyWith(
        status: TodosAddStatus.success,
        todo: todo,
      ));
    } catch (e) {
      emit(state.copyWith(status: TodosAddStatus.failure));
    }
  }
}
