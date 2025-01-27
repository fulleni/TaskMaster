import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _HomeView(), // Use the _HomeView widget
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
