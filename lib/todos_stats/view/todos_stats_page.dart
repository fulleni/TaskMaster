import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:taskmaster/settings/view/settings_page.dart';
import '../bloc/todos_stats_bloc.dart';

/// {@template todos_stats_page}
/// A widget that displays statistics of todos.
/// {@endtemplate}
class TodosStatsPage extends StatelessWidget {
  /// {@macro todos_stats_page}
  const TodosStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosStatsBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(TodosStatsLoad()),
      child: _TodosStatsView(),
    );
  }
}

class _TodosStatsView extends StatelessWidget {
  const _TodosStatsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🎯 TaskMaster'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TodosStatsBloc, TodosStatsState>(
        builder: (context, state) {
          final textColor = Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black;
          if (state.status == TodosStatsStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == TodosStatsStatus.failure) {
            return Center(
                child: Text('Failed to load stats',
                    style: TextStyle(color: textColor)));
          } else if (state.status == TodosStatsStatus.success) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30,
                              ),
                              Text(
                                'Completed Todos: ${state.numCompleted}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.pending_actions,
                                color: Colors.orange,
                                size: 30,
                              ),
                              Text(
                                'Active Todos: ${state.numActive}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
