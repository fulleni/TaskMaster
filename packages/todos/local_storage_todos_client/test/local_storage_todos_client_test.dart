import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_client/todos_client.dart';
import 'package:local_storage_todos_client/local_storage_todos_client.dart';
import 'dart:convert';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  setUpAll(() {
    registerFallbackValue(Todo(
      id: '1',
      title: 'Test Todo',
    ));
  });

  group('LocalStorageTodosClient', () {
    late MockSharedPreferences plugin;
    late LocalStorageTodosClient client;

    setUp(() {
      plugin = MockSharedPreferences();
      client = LocalStorageTodosClient(plugin: plugin);
    });

    test('initializes with empty list if no todos are stored', () {
      when(() => plugin.getString(LocalStorageTodosClient.kTodosCollectionKey))
          .thenReturn(null);

      expect(client.getTodos(), emitsInOrder([[]]));
    });

    test('initializes with stored todos', () {
      final todos = [
        Todo(id: '1', title: 'Test Todo 1'),
        Todo(id: '2', title: 'Test Todo 2'),
      ];
      when(() => plugin.getString(LocalStorageTodosClient.kTodosCollectionKey))
          .thenReturn(json.encode(todos.map((t) => t.toJson()).toList()));

      expect(client.getTodos(), emitsInOrder([todos]));
    });

    test('saves a new todo', () async {
      final todo = Todo(id: '1', title: 'Test Todo');
      when(() => plugin.getString(LocalStorageTodosClient.kTodosCollectionKey))
          .thenReturn(null);
      when(() => plugin.setString(
              LocalStorageTodosClient.kTodosCollectionKey, any()))
          .thenAnswer((_) async => true);

      await client.saveTodo(todo);

      verify(() => plugin.setString(
            LocalStorageTodosClient.kTodosCollectionKey,
            json.encode([todo.toJson()]),
          )).called(1);
    });

    test('updates an existing todo', () async {
      final todo = Todo(id: '1', title: 'Test Todo');
      final updatedTodo = todo.copyWith(title: 'Updated Test Todo');
      when(() => plugin.getString(LocalStorageTodosClient.kTodosCollectionKey))
          .thenReturn(json.encode([todo.toJson()]));
      when(() => plugin.setString(
              LocalStorageTodosClient.kTodosCollectionKey, any()))
          .thenAnswer((_) async => true);

      await client.saveTodo(updatedTodo);

      verify(() => plugin.setString(
            LocalStorageTodosClient.kTodosCollectionKey,
            json.encode([updatedTodo.toJson()]),
          )).called(1);
    });

    test('deletes a todo', () async {
      final todo = Todo(id: '1', title: 'Test Todo');
      when(() => plugin.getString(LocalStorageTodosClient.kTodosCollectionKey))
          .thenReturn(json.encode([todo.toJson()]));
      when(() => plugin.setString(
              LocalStorageTodosClient.kTodosCollectionKey, any()))
          .thenAnswer((_) async => true);

      await client.deleteTodo(todo.id);

      verify(() => plugin.setString(
            LocalStorageTodosClient.kTodosCollectionKey,
            json.encode([]),
          )).called(1);
    });

    test('throws TodoNotFoundException when deleting a non-existent todo', () {
      when(() => plugin.getString(LocalStorageTodosClient.kTodosCollectionKey))
          .thenReturn(null);

      expect(() => client.deleteTodo('non-existent-id'),
          throwsA(isA<TodoNotFoundException>()));
    });

    test('clears completed todos', () async {
      final todos = [
        Todo(id: '1', title: 'Test Todo 1', isCompleted: true),
        Todo(id: '2', title: 'Test Todo 2', isCompleted: false),
      ];
      when(() => plugin.getString(LocalStorageTodosClient.kTodosCollectionKey))
          .thenReturn(json.encode(todos.map((t) => t.toJson()).toList()));
      when(() => plugin.setString(
              LocalStorageTodosClient.kTodosCollectionKey, any()))
          .thenAnswer((_) async => true);

      final clearedCount = await client.deleteCompleted();

      expect(clearedCount, 1);
      verify(() => plugin.setString(
            LocalStorageTodosClient.kTodosCollectionKey,
            json.encode([todos[1].toJson()]),
          )).called(1);
    });

    test('completes all todos', () async {
      final todos = [
        Todo(id: '1', title: 'Test Todo 1', isCompleted: false),
        Todo(id: '2', title: 'Test Todo 2', isCompleted: false),
      ];
      final completedTodos =
          todos.map((t) => t.copyWith(isCompleted: true)).toList();
      when(() => plugin.getString(LocalStorageTodosClient.kTodosCollectionKey))
          .thenReturn(json.encode(todos.map((t) => t.toJson()).toList()));
      when(() => plugin.setString(
              LocalStorageTodosClient.kTodosCollectionKey, any()))
          .thenAnswer((_) async => true);

      final changedCount = await client.completeAll(isCompleted: true);

      expect(changedCount, 2);
      verify(() => plugin.setString(
            LocalStorageTodosClient.kTodosCollectionKey,
            json.encode(completedTodos.map((t) => t.toJson()).toList()),
          )).called(1);
    });
  });
}
