import 'package:flutter/material.dart';
import 'package:local_storage_todos_client/local_storage_todos_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos/app.dart';
import 'package:todos_repository/todos_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final todosClient = LocalStorageTodosClient(
    plugin: sharedPreferences,
  );

  final todosRepository = TodosRepository(todosClient: todosClient);

  runApp(App(
    todosRepository: todosRepository,
  ));
}
