import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmaster/app/bloc/app_bloc.dart';
import 'package:taskmaster/home/view/home_page.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';
import 'package:flutter/services.dart'; // Add this import

/// The main application widget.
class App extends StatelessWidget {
  /// Creates an instance of [App].
  const App({
    required this.todosRepository,
    required this.userPreferencesRepository,
    required this.supportedLocales,
    required this.localizationsDelegates,
    super.key,
  });

  /// The repository for managing todos.
  final TodosRepository todosRepository;

  /// The repository for managing user preferences.
  final UserPreferencesRepository userPreferencesRepository;

  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate> localizationsDelegates;

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
        child: _AppView(
          supportedLocales: supportedLocales,
          localizationsDelegates: localizationsDelegates,
        ),
      ),
    );
  }
}

/// The main view of the application.
class _AppView extends StatelessWidget {
  const _AppView({
    required this.supportedLocales,
    required this.localizationsDelegates,
  });

  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate> localizationsDelegates;

  @override
  Widget build(BuildContext context) {
    // Add platform-specific configurations
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final userPreferences =
            state.userPreferences ?? UserPreferences.defaults();

        final locale = userPreferences.language == UserPreferenceLanguage.arabic
            ? const Locale('ar')
            : const Locale('en');

        final title = userPreferences.language == UserPreferenceLanguage.arabic
            ? 'تاسك ماستر'
            : 'TaskMaster';

        final themeMode = UserPreferenceThemeModeX.toFlutterThemeMode(
            userPreferences.themeMode);
        final flexScheme = UserPreferenceAccentColorX.toFlexScheme(
          userPreferences.themeAccentColor,
        );
        final fontScale = UserPreferenceFontSizeX.toFontSize(
          userPreferences.fontSize,
        );

        final textTheme = UserPreferenceFontFamilyX.toGoogleFontsTextTheme(
          userPreferences.fontFamily,
          Theme.of(context).textTheme,
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: locale,
          title: title,
          theme: FlexThemeData.light(scheme: flexScheme).copyWith(
            textTheme: textTheme,
            platform: TargetPlatform.android,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
          ),
          darkTheme: FlexThemeData.dark(scheme: flexScheme).copyWith(
            textTheme: textTheme,
            platform: TargetPlatform.android,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
          ),
          themeMode: themeMode,
          home: const HomePage(),
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
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

/// Extension to convert [UserPreferenceThemeMode] to [ThemeMode].
extension UserPreferenceThemeModeX on UserPreferenceThemeMode {
  /// Converts [UserPreferenceThemeMode] to [ThemeMode].
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

/// Extension to convert [UserPreferenceAccentColor] to [FlexScheme].
extension UserPreferenceAccentColorX on UserPreferenceAccentColor {
  /// Converts [UserPreferenceAccentColor] to [FlexScheme].
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

/// Extension to convert [UserPreferenceFontSize] to a double value.
extension UserPreferenceFontSizeX on UserPreferenceFontSize {
  /// Converts [UserPreferenceFontSize] to a double value.
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

/// Extension to convert [UserPreferenceFontFamily] to a [TextTheme] using GoogleFonts.
extension UserPreferenceFontFamilyX on UserPreferenceFontFamily {
  /// Converts [UserPreferenceFontFamily] to a [TextTheme] using GoogleFonts.
  static TextTheme toGoogleFontsTextTheme(
    UserPreferenceFontFamily fontFamily,
    TextTheme baseTextTheme,
  ) {
    switch (fontFamily) {
      case UserPreferenceFontFamily.roboto:
        return GoogleFonts.robotoTextTheme(baseTextTheme);
      case UserPreferenceFontFamily.openSans:
        return GoogleFonts.openSansTextTheme(baseTextTheme);
      case UserPreferenceFontFamily.lato:
        return GoogleFonts.latoTextTheme(baseTextTheme);
      case UserPreferenceFontFamily.raleway:
        return GoogleFonts.ralewayTextTheme(baseTextTheme);
      case UserPreferenceFontFamily.montserrat:
        return GoogleFonts.montserratTextTheme(baseTextTheme);
      case UserPreferenceFontFamily.merriweather:
        return GoogleFonts.merriweatherTextTheme(baseTextTheme);
      case UserPreferenceFontFamily.nunito:
        return GoogleFonts.nunitoTextTheme(baseTextTheme);
      case UserPreferenceFontFamily.playfairDisplay:
        return GoogleFonts.playfairDisplayTextTheme(baseTextTheme);
      case UserPreferenceFontFamily.sourceSansPro:
        return GoogleFonts.sourceSans3TextTheme(baseTextTheme);
      case UserPreferenceFontFamily.ubuntu:
        return GoogleFonts.ubuntuTextTheme(baseTextTheme);
    }
  }
}
