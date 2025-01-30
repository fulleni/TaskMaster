import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmaster/settings/view/settings_page.dart';
import 'package:taskmaster/todos_edit/bloc/todos_edit_bloc.dart';
import 'package:todos_repository/todos_repository.dart';
import '../bloc/todos_overview_bloc.dart';
import '../../todos_edit/view/todos_edit_page.dart';
import 'package:taskmaster/l10n/l10n.dart';

/// {@template todos_overview}
/// A widget that displays an overview of todos.
/// {@endtemplate}
class TodosOverviewPage extends StatelessWidget {
  /// {@macro todos_overview}
  const TodosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosOverviewBloc(
            todosRepository: context.read<TodosRepository>(),
          )..add(TodosOverviewLoadTodos()),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => TodosEditBloc(
            todosRepository: context.read<TodosRepository>(),
          ),
        ),
      ],
      child: _TodosOverviewView(),
    );
  }
}

class _TodosOverviewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
          child: Image.asset(
            'assets/logo/taskMaster.png',
            opacity: const AlwaysStoppedAnimation(0.9),
          ),
        ),
        actions: [
          _TodosOverviewFilterButton(),
          // _TodosOverviewOptionsButton(),
          _TodosOverviewSettingsButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodosEditBloc, TodosEditState>(
            listenWhen: (previous, current) =>
                current.status == TodosEditStatus.success,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.successfullyUpdated),
                  action: SnackBarAction(
                    label: context.l10n.undo,
                    onPressed: () {
                      context
                          .read<TodosOverviewBloc>()
                          .add(TodosOverviewUndoUpdate(
                            initialTodo: state.todo!,
                          ));
                    },
                  ),
                ),
              );
            },
          ),
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTodo != current.lastDeletedTodo &&
                current.lastDeletedTodo != null,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.successfullyDeleted),
                  action: SnackBarAction(
                    label: context.l10n.undo,
                    onPressed: () {
                      context
                          .read<TodosOverviewBloc>()
                          .add(TodosOverviewUndoDelete());
                    },
                  ),
                ),
              );
            },
          ),
        ],
        child: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
          builder: (context, state) {
            if (state.status == TodosOverviewStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == TodosOverviewStatus.failure) {
              final textColor = Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black;
              return Center(
                  child: Text(context.l10n.failedToLoadTodos,
                      style: TextStyle(color: textColor)));
            } else if (state.todos.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<TodosOverviewBloc>()
                      .add(TodosOverviewLoadTodos());
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Center(
                          child: Card(
                            elevation: 2,
                            margin: const EdgeInsets.all(16),
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.task_outlined,
                                    size: 120,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white54
                                        : Colors.black38,
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                    context.l10n.noTodosAvailable,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    context.l10n.tapToAddFirstTask,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white60
                                              : Colors.black45,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<TodosOverviewBloc>()
                      .add(TodosOverviewLoadTodos());
                },
                child: ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return Dismissible(
                      key: Key(todo.id),
                      onDismissed: (direction) {
                        context.read<TodosOverviewBloc>().add(
                              TodosOverviewDeleteTodo(todo.id),
                            );
                      },
                      background: Container(
                        color: Colors.red.shade300,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              fontSize: 18,
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            todo.description,
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                          trailing: Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (value) {
                                context.read<TodosOverviewBloc>().add(
                                      TodosOverviewToggleTodoCompleted(
                                          todo.id, value!),
                                    );
                              },
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TodosEditPage(todo: todo),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _TodosOverviewSettingsButton extends StatelessWidget {
  const _TodosOverviewSettingsButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
      },
    );
  }
}

// class _TodosOverviewOptionsButton extends StatelessWidget {
//   const _TodosOverviewOptionsButton();

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(
//       onSelected: (value) {
//         switch (value) {
//           case 'toggleAll':
//             final allCompleted = context
//                 .read<TodosOverviewBloc>()
//                 .state
//                 .todos
//                 .every((todo) => todo.isCompleted);
//             context
//                 .read<TodosOverviewBloc>()
//                 .add(TodosOverviewToggleCompleteAll(!allCompleted));
//             break;
//           case 'deleteCompleted':
//             context
//                 .read<TodosOverviewBloc>()
//                 .add(TodosOverviewDeleteCompleted());
//             break;
//         }
//       },
//       itemBuilder: (context) => <PopupMenuEntry<String>>[
//         const PopupMenuItem<String>(
//           value: 'toggleAll',
//           child: Text('Toggle All'),
//         ),
//         const PopupMenuItem<String>(
//           value: 'deleteCompleted',
//           child: Text('Delete Completed'),
//         ),
//       ],
//     );
//   }
// }

class _TodosOverviewFilterButton extends StatelessWidget {
  const _TodosOverviewFilterButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () {
        // This will open the PopupMenuButton
        final RenderBox button = context.findRenderObject() as RenderBox;
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            button.localToGlobal(Offset.zero, ancestor: overlay),
            button.localToGlobal(button.size.bottomRight(Offset.zero),
                ancestor: overlay),
          ),
          Offset.zero & overlay.size,
        );
        showMenu<TodosOverviewFilter>(
          context: context,
          position: position,
          items: <PopupMenuEntry<TodosOverviewFilter>>[
            PopupMenuItem<TodosOverviewFilter>(
              value: TodosOverviewFilter.all,
              child: Text(context.l10n.showAll),
            ),
            PopupMenuItem<TodosOverviewFilter>(
              value: TodosOverviewFilter.completedOnly,
              child: Text(context.l10n.showCompleted),
            ),
            PopupMenuItem<TodosOverviewFilter>(
              value: TodosOverviewFilter.uncompletedOnly,
              child: Text(context.l10n.showUncompleted),
            ),
          ],
        ).then((filter) {
          if (filter != null && context.mounted) {
            context
                .read<TodosOverviewBloc>()
                .add(TodosOverviewFilterTodos(filter));
          }
        });
      },
    );
  }
}
