import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
          child: Image.asset(
            'assets/taskMaster.png',
            fit: BoxFit.contain,
          ),
        ),
        title: Text(l10n.taskmaster),
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
                child: Text(l10n.failedToLoadStats,
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
                                l10n.completedTodos(state.numCompleted),
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
                                size: 30,
                              ),
                              Text(
                                l10n.activeTodos(state.numActive),
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
