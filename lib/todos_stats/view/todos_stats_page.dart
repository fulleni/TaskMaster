import 'package:flutter/material.dart';

/// {@template todos_stats_page}
/// A widget that displays statistics of todos.
/// {@endtemplate}
class TodosStatsPage extends StatelessWidget {
  /// {@macro todos_stats_page}
  const TodosStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos Stats'), // Title of the app bar
      ),
      body: Center(
        child: Text('Todos Stats Content'), // Centered text for the content
      ),
    );
  }
}
