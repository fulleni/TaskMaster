import 'package:flutter/material.dart';

/// {@template todos_overview}
/// A widget that displays an overview of todos.
/// {@endtemplate}
class TodosOverviewPage extends StatelessWidget {
  /// {@macro todos_overview}
  const TodosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos Overview'), // Title of the app bar
      ),
      body: Center(
        child: Text('Todos Overview Content'), // Centered text for the content
      ),
    );
  }
}
