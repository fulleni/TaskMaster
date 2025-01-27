import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_overview_event.dart';
part 'todos_overview_state.dart';

class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
  TodosOverviewBloc({required TodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(const TodosOverviewState()) {
    on<TodosOverviewLoadTodos>(_onLoadTodos);
    on<TodosOverviewDeleteTodo>(_onDeleteTodo);
    on<TodosOverviewUndoDelete>(_onUndoDelete);
    on<TodosOverviewToggleTodoCompleted>(_onToggleTodoCompleted);
    on<TodosOverviewToggleCompleteAll>(_onToggleCompleteAll);
    on<TodosOverviewClearCompleted>(_onClearCompleted);
    on<TodosOverviewDeleteAllCompleted>(_onDeleteAllCompleted);
    on<TodosOverviewFilterTodos>(_onFilterTodos);
  }

  final TodosRepository _todosRepository;

  /// Handles the [TodosOverviewLoadTodos] event.
  ///
  /// Emits a loading state, then attempts to load todos from the repository.
  /// If successful, emits a success state with the loaded todos.
  /// If an error occurs, emits a failure state.
  Future<void> _onLoadTodos(
    TodosOverviewLoadTodos event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));
    try {
      await emit.forEach<List<Todo>>(
        _todosRepository.getTodos(),
        onData: (todos) => state.copyWith(
          status: TodosOverviewStatus.success,
          todos: todos,
        ),
        onError: (_, __) => state.copyWith(status: TodosOverviewStatus.failure),
      );
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  /// Handles the [TodosOverviewDeleteTodo] event.
  ///
  /// Emits a loading state, then attempts to delete the specified todo.
  /// If successful, emits a state with the last deleted todo and reloads todos.
  /// If an error occurs, emits a failure state.
  Future<void> _onDeleteTodo(
    TodosOverviewDeleteTodo event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));
    try {
      final todo = state.todos.firstWhere((todo) => todo.id == event.id);
      await _todosRepository.deleteTodo(event.id);
      emit(state.copyWith(lastDeletedTodo: todo));
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  /// Handles the [TodosOverviewUndoDelete] event.
  ///
  /// Emits a loading state, then attempts to restore the last deleted todo.
  /// If successful, emits a state with the last deleted todo set to null and reloads todos.
  /// If an error occurs, emits a failure state.
  Future<void> _onUndoDelete(
    TodosOverviewUndoDelete event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));
    try {
      if (state.lastDeletedTodo != null) {
        await _todosRepository.saveTodo(state.lastDeletedTodo!);
        emit(state.copyWith(lastDeletedTodo: null));
        add(TodosOverviewLoadTodos());
      }
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  /// Handles the [TodosOverviewToggleTodoCompleted] event.
  ///
  /// Emits a loading state, then attempts to update the completion status of the specified todo.
  /// If successful, reloads todos.
  /// If an error occurs, emits a failure state.
  Future<void> _onToggleTodoCompleted(
    TodosOverviewToggleTodoCompleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));
    try {
      final todo = state.todos.firstWhere((todo) => todo.id == event.id);
      final updatedTodo = todo.copyWith(isCompleted: event.isCompleted);
      await _todosRepository.saveTodo(updatedTodo);
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  /// Handles the [TodosOverviewToggleCompleteAll] event.
  ///
  /// Emits a loading state, then attempts to update the completion status of all todos.
  /// If successful, reloads todos.
  /// If an error occurs, emits a failure state.
  Future<void> _onToggleCompleteAll(
    TodosOverviewToggleCompleteAll event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));
    try {
      await _todosRepository.completeAll(isCompleted: event.isCompleted);
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  /// Handles the [TodosOverviewClearCompleted] event.
  ///
  /// Emits a loading state, then attempts to clear all completed todos.
  /// If successful, reloads todos.
  /// If an error occurs, emits a failure state.
  Future<void> _onClearCompleted(
    TodosOverviewClearCompleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));
    try {
      await _todosRepository.clearCompleted();
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  /// Handles the [TodosOverviewDeleteAllCompleted] event.
  ///
  /// Emits a loading state, then attempts to delete all completed todos.
  /// If successful, reloads todos.
  /// If an error occurs, emits a failure state.
  Future<void> _onDeleteAllCompleted(
    TodosOverviewDeleteAllCompleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));
    try {
      await _todosRepository.clearCompleted();
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  /// Handles the [TodosOverviewFilterTodos] event.
  ///
  /// Emits a loading state, then attempts to filter the todos based on the selected filter.
  /// If successful, emits a success state with the filtered todos.
  /// If an error occurs, emits a failure state.
  Future<void> _onFilterTodos(
    TodosOverviewFilterTodos event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));
    try {
      final todos = await _todosRepository.getTodos().first;
      final filteredTodos = _filterTodos(todos, event.filter);
      emit(state.copyWith(
        filter: event.filter,
        todos: filteredTodos,
        status: TodosOverviewStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  /// Filters the todos based on the selected filter.
  ///
  /// Returns a list of todos that match the filter criteria.
  List<Todo> _filterTodos(List<Todo> todos, TodosOverviewFilter filter) {
    switch (filter) {
      case TodosOverviewFilter.completedOnly:
        return todos.where((todo) => todo.isCompleted).toList();
      case TodosOverviewFilter.uncompletedOnly:
        return todos.where((todo) => !todo.isCompleted).toList();
      case TodosOverviewFilter.all:
        return todos;
    }
  }
}
