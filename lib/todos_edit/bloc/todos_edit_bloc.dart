import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_edit_event.dart';
part 'todos_edit_state.dart';

/// {@template todos_edit_bloc}
/// A bloc that handles the editing of todos.
/// {@endtemplate}
class TodosEditBloc extends Bloc<TodosEditEvent, TodosEditState> {
  /// {@macro todos_edit_bloc}
  TodosEditBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const TodosEditState()) {
    on<TodosEditLoadTodo>(_onLoadTodo);
    on<TodosEditTitleChanged>(_onTitleChanged);
    on<TodosEditDescriptionChanged>(_onDescriptionChanged);
    on<TodosEditSubmitted>(_onSubmitted);
  }

  final TodosRepository _todosRepository;

  /// Handles the loading of an existing todo for editing.
  ///
  /// Emits a new state with the todo's current values.
  /// Throws [StateError] if the todo is null.
  void _onLoadTodo(TodosEditLoadTodo event, Emitter<TodosEditState> emit) {
    try {
      emit(state.copyWith(
        todo: event.todo,
        title: event.todo.title,
        description: event.todo.description,
      ));
    } catch (e) {
      emit(state.copyWith(status: TodosEditStatus.failure));
    }
  }

  /// Handles changes to the todo title.
  ///
  /// Emits a new state with the updated title.
  /// Validates that title is not null.
  void _onTitleChanged(
    TodosEditTitleChanged event,
    Emitter<TodosEditState> emit,
  ) {
    try {
      emit(state.copyWith(
        title: event.title,
        status: TodosEditStatus.initial,
      ));
    } catch (e) {
      emit(state.copyWith(status: TodosEditStatus.failure));
    }
  }

  /// Handles changes to the todo description.
  ///
  /// Emits a new state with the updated description.
  /// Validates that description is not null.
  void _onDescriptionChanged(
    TodosEditDescriptionChanged event,
    Emitter<TodosEditState> emit,
  ) {
    try {
      emit(state.copyWith(
        description: event.description,
        status: TodosEditStatus.initial,
      ));
    } catch (e) {
      emit(state.copyWith(status: TodosEditStatus.failure));
    }
  }

  /// Handles the submission of edited todo data.
  ///
  /// Validates the todo data and saves it to the repository.
  /// Emits success status on successful save, failure status on error.
  ///
  /// Throws:
  /// * [StateError] if initialTodo is null
  /// * [ArgumentError] if title is empty
  Future<void> _onSubmitted(
    TodosEditSubmitted event,
    Emitter<TodosEditState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TodosEditStatus.loading));

      if (state.todo == null) {
        throw StateError('Cannot submit without initial todo');
      }

      if (state.title.isEmpty) {
        throw ArgumentError('Title cannot be empty');
      }

      final updatedTodo = state.todo!.copyWith(
        title: state.title,
        description: state.description,
      );

      await _todosRepository.saveTodo(updatedTodo);
      emit(state.copyWith(status: TodosEditStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: TodosEditStatus.failure,
      ));
    }
  }
}
