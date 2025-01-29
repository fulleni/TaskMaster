import 'package:flutter/material.dart';
import 'package:local_storage_todos_client/local_storage_todos_client.dart';
import 'package:local_storage_user_preferences_client/local_storage_user_preferences_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmaster/app/view/app.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final todosClient = LocalStorageTodosClient(
    sharedPreferences: sharedPreferences,
  );
  final userPreferencesClient = LocalStorageUserPreferencesClient(
    sharedPreferences: sharedPreferences,
  );
  final todosRepository = TodosRepository(todosClient: todosClient);

  final userPreferencesRepository = UserPreferencesRepository(
    client: userPreferencesClient,
  );

  runApp(
    App(
      todosRepository: todosRepository,
      userPreferencesRepository: userPreferencesRepository,
    ),
  );
}
