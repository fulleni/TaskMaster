import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmaster/todos_add/view/todos_add_page.dart';
import 'package:taskmaster/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:todos_repository/todos_repository.dart';
import '../cubit/home_cubit.dart';
import '../../todos_overview/view/todos_overview_page.dart';
import '../../todos_stats/view/todos_stats_page.dart';

/// {@template home_page}
/// The HomePage widget is the main entry point of the app.
/// It contains buttons to navigate to the TodosPage and TodosStatsPage.
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(),
          // Use the _HomeView widget
        ),
        BlocProvider(
          create: (context) => TodosOverviewBloc(
            todosRepository: context.read<TodosRepository>(),
          ),
        ),
      ],
      child: const _HomeView(),
    );
  }
}

/// A private stateless widget that represents the view of the HomePage.
class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.selectedTab.index,
            children: const [
              TodosOverviewPage(),
              TodosStatsPage(),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.selectedTab != current.selectedTab,
        builder: (context, state) {
          if (state.selectedTab == HomeTab.todos) {
            final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
            return FloatingActionButton(
              key: const Key('homeView_addTodo_floatingActionButton'),
              onPressed: () async {
                final todo = await Navigator.of(context).push<Todo>(
                  MaterialPageRoute(builder: (_) => const TodosAddPage()),
                );
                if (todo != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added "${todo.title}"'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          context
                              .read<TodosOverviewBloc>()
                              .add(TodosOverviewDeleteTodo(todo.id));
                        },
                      ),
                    ),
                  );
                }
              },
              backgroundColor: isDarkTheme ? Colors.grey[800] : Colors.blue,
              foregroundColor: Colors.white,
              elevation: isDarkTheme ? 4.0 : 6.0,
              child: const Icon(Icons.add),
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
          return BottomNavigationBar(
            currentIndex: state.selectedTab.index,
            onTap: (index) =>
                context.read<HomeCubit>().setTab(HomeTab.values[index]),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Todos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Stats',
              ),
            ],
            backgroundColor: isDarkTheme ? Colors.grey[850] : Colors.white,
            selectedItemColor: isDarkTheme ? Colors.white : Colors.blue,
            unselectedItemColor: isDarkTheme ? Colors.grey : Colors.black54,
          );
        },
      ),
    );
  }
}
