import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_stats_event.dart';
part 'todos_stats_state.dart';

class TodosStatsBloc extends Bloc<TodosStatsEvent, TodosStatsState> {
  TodosStatsBloc({required TodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(const TodosStatsState()) {
    on<TodosStatsLoad>(_onLoad);
  }

  final TodosRepository _todosRepository;

  Future<void> _onLoad(
    TodosStatsLoad event,
    Emitter<TodosStatsState> emit,
  ) async {
    emit(state.copyWith(status: TodosStatsStatus.loading));
    try {
      await emit.forEach<List<Todo>>(
        _todosRepository.getTodos(),
        onData: (todos) {
          final numCompleted = todos.where((todo) => todo.isCompleted).length;
          final numActive = todos.length - numCompleted;
          return state.copyWith(
            numCompleted: numCompleted,
            numActive: numActive,
            status: TodosStatsStatus.success,
          );
        },
      );
    } catch (_) {
      emit(state.copyWith(status: TodosStatsStatus.failure));
    }
  }
}
