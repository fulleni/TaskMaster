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
  }

  final TodosRepository _todosRepository;

  Future<void> _onLoadTodos(
    TodosOverviewLoadTodos event,
    Emitter<TodosOverviewState> emit,
  ) async {
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

  Future<void> _onDeleteTodo(
    TodosOverviewDeleteTodo event,
    Emitter<TodosOverviewState> emit,
  ) async {
    try {
      final todo = state.todos.firstWhere((todo) => todo.id == event.id);
      await _todosRepository.deleteTodo(event.id);
      emit(state.copyWith(lastDeletedTodo: todo));
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  Future<void> _onUndoDelete(
    TodosOverviewUndoDelete event,
    Emitter<TodosOverviewState> emit,
  ) async {
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

  Future<void> _onToggleTodoCompleted(
    TodosOverviewToggleTodoCompleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    try {
      final todo = state.todos.firstWhere((todo) => todo.id == event.id);
      final updatedTodo = todo.copyWith(isCompleted: event.isCompleted);
      await _todosRepository.saveTodo(updatedTodo);
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  Future<void> _onToggleCompleteAll(
    TodosOverviewToggleCompleteAll event,
    Emitter<TodosOverviewState> emit,
  ) async {
    try {
      await _todosRepository.completeAll(isCompleted: event.isCompleted);
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  Future<void> _onClearCompleted(
    TodosOverviewClearCompleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    try {
      await _todosRepository.clearCompleted();
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }

  Future<void> _onDeleteAllCompleted(
    TodosOverviewDeleteAllCompleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    try {
      await _todosRepository.clearCompleted();
      add(TodosOverviewLoadTodos());
    } catch (_) {
      emit(state.copyWith(status: TodosOverviewStatus.failure));
    }
  }
}
