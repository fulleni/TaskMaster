import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        final themeMode =
            ThemeModeExtension.fromUserPreference(userPreferences.themeMode);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TaskMaster',
          theme: lightTheme,
          darkTheme: darkTheme,
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
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}

extension ThemeModeExtension on ThemeMode {
  static ThemeMode fromUserPreference(UserPreferenceThemeMode userPreference) {
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

extension MaterialColorExtension on MaterialColor {
  static MaterialColor fromUserPreference({
    required UserPreferenceAccentColor userPreference,
    required ThemeMode themeMode,
  }) {
    if (themeMode == ThemeMode.dark) {
      switch (userPreference) {
        case UserPreferenceAccentColor.accentOne:
          return Colors.lightBlue;
        case UserPreferenceAccentColor.accentTwo:
          return Colors.cyan;
        case UserPreferenceAccentColor.accentThree:
          return Colors.lime;
      }
    } else {
      switch (userPreference) {
        case UserPreferenceAccentColor.accentOne:
          return Colors.blue;
        case UserPreferenceAccentColor.accentTwo:
          return Colors.teal;
        case UserPreferenceAccentColor.accentThree:
          return Colors.amber;
      }
    }
  }
}

ThemeData lightTheme = ThemeData(
  useMaterial3: true, // Modern Material Design 3
  colorScheme: ColorScheme.light(
    primary: Colors.grey[300]!, // Slightly lighter primary
    onPrimary: Colors.grey[800]!, // Darker text on primary
    secondary: Colors.grey[400]!, // A bit darker secondary
    onSecondary: Colors.grey[900]!, // Dark text on background
    surface: Colors.grey[200]!, // Light surface (cards, dialogs)
    onSurface: Colors.grey[800]!, // Dark text on surface
    error: Colors.red[400]!, // Keep error color distinct
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[200], // Light app bar
    foregroundColor: Colors.grey[900], // Dark text on app bar
    elevation: 1, // Subtle elevation
    scrolledUnderElevation: 1, // Elevation when scrolled under
    shadowColor: Colors.grey.withOpacity(0.2), // Shadow for scrolled appbar
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.grey[800]),
    bodyMedium: TextStyle(color: Colors.grey[700]),
    bodySmall: TextStyle(color: Colors.grey[600]),
    titleLarge: TextStyle(
      color: Colors.grey[900],
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.grey[800],
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: Colors.grey[700],
    ),
    // ... other text styles
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[400],
      foregroundColor: Colors.grey[900],
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.grey[700],
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide(color: Colors.grey[500]!),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.grey[700],
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[50],
    border: OutlineInputBorder(
      borderSide: BorderSide.none, // No border by default
      borderRadius: BorderRadius.circular(8),
    ),
    hintStyle: TextStyle(color: Colors.grey[600]),
    labelStyle: TextStyle(color: Colors.grey[700]),
    prefixIconColor: Colors.grey[600],
    suffixIconColor: Colors.grey[600],
  ),
  // Add other component themes as needed (e.g., BottomAppBarTheme, etc.)
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: Colors.grey[700]!,
    onPrimary: Colors.grey[200]!,
    secondary: Colors.grey[600]!,
    onSecondary: Colors.grey[100]!,
    surface: Colors.grey[800]!,
    onSurface: Colors.grey[200]!,
    error: Colors.red[600]!,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[800],
    foregroundColor: Colors.grey[200],
    elevation: 1,
    scrolledUnderElevation: 1,
    shadowColor: Colors.black.withOpacity(0.3),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.grey[300]),
    bodyMedium: TextStyle(color: Colors.grey[400]),
    bodySmall: TextStyle(color: Colors.grey[500]),
    titleLarge: TextStyle(
      color: Colors.grey[100],
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.grey[200],
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: Colors.grey[300],
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[600],
      foregroundColor: Colors.grey[100],
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.grey[400],
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide(color: Colors.grey[500]!),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.grey[400],
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[700],
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    ),
    hintStyle: TextStyle(color: Colors.grey[500]),
    labelStyle: TextStyle(color: Colors.grey[400]),
    prefixIconColor: Colors.grey[500],
    suffixIconColor: Colors.grey[500],
  ),
);
