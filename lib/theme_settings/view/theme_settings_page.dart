import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmaster/theme_settings/bloc/theme_settings_bloc.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeSettingsBloc(
        userPreferencesRepository: context.read<UserPreferencesRepository>(),
      )..add(const LoadThemeSettings()),
      child: const _ThemeSettingsView(),
    );
  }
}

class _ThemeSettingsView extends StatelessWidget {
  const _ThemeSettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: BlocBuilder<ThemeSettingsBloc, ThemeSettingsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.hasError) {
            return const Center(child: Text('Failed to load theme settings'));
          } else {
            final textColor = Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Theme Mode',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      DropdownButton<UserPreferenceThemeMode>(
                        value: state.themeMode,
                        hint: Text('Select Theme Mode',
                            style: TextStyle(color: textColor)),
                        items: UserPreferenceThemeMode.values.map((themeMode) {
                          return DropdownMenuItem(
                            value: themeMode,
                            child: Text(themeMode.toString().split('.').last,
                                style: TextStyle(color: textColor)),
                          );
                        }).toList(),
                        onChanged: (themeMode) {
                          if (themeMode != null) {
                            context
                                .read<ThemeSettingsBloc>()
                                .add(UpdateThemeMode(themeMode));
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Accent Color',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      DropdownButton<UserPreferenceAccentColor>(
                        value: state.accentColor,
                        hint: Text('Select Accent Color',
                            style: TextStyle(color: textColor)),
                        items:
                            UserPreferenceAccentColor.values.map((accentColor) {
                          return DropdownMenuItem(
                            value: accentColor,
                            child: Text(accentColor.toString().split('.').last,
                                style: TextStyle(color: textColor)),
                          );
                        }).toList(),
                        onChanged: (accentColor) {
                          if (accentColor != null) {
                            context
                                .read<ThemeSettingsBloc>()
                                .add(UpdateThemeAccentColor(accentColor));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
