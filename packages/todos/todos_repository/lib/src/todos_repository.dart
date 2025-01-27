import 'package:todos_client/todos_client.dart';

/// {@template todos_repository}
/// A repository that handles `todo` related requests.
/// {@endtemplate}
class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository({
    required TodosClient todosClient,
  }) : _todosClient = todosClient;

  final TodosClient _todosClient;

  /// Provides a [Stream] of all todos.
  Stream<List<Todo>> getTodos() => _todosClient.getTodos();

  /// Saves a [todo].
  ///
  /// If a [todo] with the same id already exists, it will be replaced.
  Future<void> saveTodo(Todo todo) => _todosClient.saveTodo(todo);

  /// Deletes the `todo` with the given id.
  ///
  /// If no `todo` with the given id exists, a [TodoNotFoundException] error is
  /// thrown.
  Future<void> deleteTodo(String id) => _todosClient.deleteTodo(id);

  /// Deletes all completed todos.
  ///
  /// Returns the number of deleted todos.
  Future<int> deleteCompleted() => _todosClient.deleteCompleted();

  /// Sets the `isCompleted` state of all todos to the given value.
  ///
  /// Returns the number of updated todos.
  Future<int> completeAll({required bool isCompleted}) =>
      _todosClient.completeAll(isCompleted: isCompleted);
}
