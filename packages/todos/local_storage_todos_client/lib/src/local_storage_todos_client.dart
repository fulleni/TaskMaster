import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_client/todos_client.dart';

/// {@template local_storage_todos_client}
/// A Flutter implementation of the [TodosClient] that uses local storage.
/// Handles persistence of todo items using SharedPreferences and provides
/// reactive updates through a BehaviorSubject stream.
/// {@endtemplate}
class LocalStorageTodosClient extends TodosClient {
  /// {@macro local_storage_todos_client}
  LocalStorageTodosClient({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  /// The [SharedPreferences] plugin used for local storage.
  final SharedPreferences _plugin;

  /// A [BehaviorSubject] that holds the current list of todos.
  late final _todoStreamController = BehaviorSubject<List<Todo>>.seeded(
    const [],
  );

  /// The key used for storing the todos locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kTodosCollectionKey = '__todos_collection_key__';

  /// Retrieves a value from local storage by key.
  ///
  /// Returns the value as a [String] if it exists, otherwise returns `null`.
  String? _getValue(String key) => _plugin.getString(key);

  /// Sets a value in local storage by key.
  ///
  /// Takes a [String] key and a [String] value and stores them in local storage.
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  /// Initializes the client by loading todos from local storage.
  ///
  /// If todos are found in local storage, they are added to the stream.
  /// Otherwise, an empty list is added to the stream.
  void _init() {
    final todosJson = _getValue(kTodosCollectionKey);
    if (todosJson != null) {
      final todos = List<Map<dynamic, dynamic>>.from(
        json.decode(todosJson) as List,
      )
          .map((jsonMap) => Todo.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _todoStreamController.add(todos);
    } else {
      final mockedTodos = List.generate(
        5,
        (index) => Todo(
          title: 'Mocked Todo $index',
          description: 'Description for mocked todo $index',
        ),
      );
      _todoStreamController.add(mockedTodos);
    }
  }

  /// Returns a stream of the current list of todos.
  ///
  /// The stream is broadcast, allowing multiple listeners.
  @override
  Stream<List<Todo>> getTodos() => _todoStreamController.asBroadcastStream();

  /// Saves a [Todo] to local storage.
  ///
  /// If a todo with the same id already exists, it is updated.
  /// Otherwise, the new todo is added to the list.
  @override
  Future<void> saveTodo(Todo todo) {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == todo.id);
    if (todoIndex >= 0) {
      todos[todoIndex] = todo;
    } else {
      todos.add(todo);
    }

    _todoStreamController.add(todos);
    return _setValue(kTodosCollectionKey, json.encode(todos));
  }

  /// Deletes a [Todo] from local storage by id.
  ///
  /// Throws a [TodoNotFoundException] if the todo with the given id is not found.
  @override
  Future<void> deleteTodo(String id) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == id);
    if (todoIndex == -1) {
      throw TodoNotFoundException();
    } else {
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
      return _setValue(kTodosCollectionKey, json.encode(todos));
    }
  }

  /// Clears all completed todos from local storage.
  ///
  /// Returns the number of todos that were cleared.
  @override
  Future<int> deleteCompleted() async {
    final todos = [..._todoStreamController.value];
    final completedTodosAmount = todos.where((t) => t.isCompleted).length;
    todos.removeWhere((t) => t.isCompleted);
    _todoStreamController.add(todos);
    await _setValue(kTodosCollectionKey, json.encode(todos));
    return completedTodosAmount;
  }

  /// Marks all todos as completed or not completed.
  ///
  /// Takes a boolean [isCompleted] to set the completion status.
  /// Returns the number of todos that were changed.
  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final todos = [..._todoStreamController.value];
    final changedTodosAmount =
        todos.where((t) => t.isCompleted != isCompleted).length;
    final newTodos = [
      for (final todo in todos) todo.copyWith(isCompleted: isCompleted),
    ];
    _todoStreamController.add(newTodos);
    await _setValue(kTodosCollectionKey, json.encode(newTodos));
    return changedTodosAmount;
  }

  /// Closes the stream controller.
  ///
  /// Should be called when the client is no longer needed to release resources.
  @override
  Future<void> close() {
    return _todoStreamController.close();
  }
}
