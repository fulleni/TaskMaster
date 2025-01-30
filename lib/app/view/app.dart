import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskmaster/app/bloc/app_bloc.dart';
import 'package:taskmaster/home/view/home_page.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.todosRepository,
    required this.userPreferencesRepository,
    super.key,
  });

  final TodosRepository todosRepository;
  final UserPreferencesRepository userPreferencesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: todosRepository,
        ),
        RepositoryProvider.value(
          value: userPreferencesRepository,
        ),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(
          userPreferencesRepository: userPreferencesRepository,
        )..add(AppLoaded()),
        child: _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final userPreferences =
            state.userPreferences ?? UserPreferences.defaults();
        final themeMode = UserPreferenceThemeModeX.toFlutterThemeMode(
            userPreferences.themeMode);
        final flexScheme = UserPreferenceAccentColorX.toFlexScheme(
          userPreferences.themeAccentColor,
        );
        final fontScale = UserPreferenceFontSizeX.toFontSize(
          userPreferences.fontSize,
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TaskMaster',
          theme: FlexThemeData.light(scheme: flexScheme).copyWith(),
          darkTheme: FlexThemeData.dark(scheme: flexScheme),
          themeMode: themeMode,
          home: const HomePage(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('ar', ''), // Arabic
          ],
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(fontScale),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}

extension UserPreferenceThemeModeX on UserPreferenceThemeMode {
  static ThemeMode toFlutterThemeMode(UserPreferenceThemeMode userPreference) {
    switch (userPreference) {
      case UserPreferenceThemeMode.light:
        return ThemeMode.light;
      case UserPreferenceThemeMode.dark:
        return ThemeMode.dark;
      case UserPreferenceThemeMode.system:
        return ThemeMode.system;
    }
  }
}

extension UserPreferenceAccentColorX on UserPreferenceAccentColor {
  static FlexScheme toFlexScheme(UserPreferenceAccentColor accentColor) {
    switch (accentColor) {
      case UserPreferenceAccentColor.blue:
        return FlexScheme.blue;
      case UserPreferenceAccentColor.grey:
        return FlexScheme.greys;
      case UserPreferenceAccentColor.red:
        return FlexScheme.red;
    }
  }
}

extension UserPreferenceFontSizeX on UserPreferenceFontSize {
  static double toFontSize(UserPreferenceFontSize fontSize) {
    switch (fontSize) {
      case UserPreferenceFontSize.defaultSize:
        return 1.0;
      case UserPreferenceFontSize.mediumSize:
        return 1.1;
      case UserPreferenceFontSize.largeSize:
        return 1.2;
    }
  }
}
