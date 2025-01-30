import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmaster/theme_settings/bloc/theme_settings_bloc.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.themeSettings),
      ),
      body: BlocBuilder<ThemeSettingsBloc, ThemeSettingsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.hasError) {
            return Center(child: Text(l10n.failedToLoadThemeSettings));
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
                        l10n.mode,
                        style: TextStyle(color: textColor),
                      ),
                      DropdownButton<UserPreferenceThemeMode>(
                        value: state.themeMode,
                        hint: Text(l10n.selectThemeMode,
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
                        l10n.accentColor,
                        style: TextStyle(color: textColor),
                      ),
                      DropdownButton<UserPreferenceAccentColor>(
                        value: state.accentColor,
                        hint: Text(l10n.selectAccentColor,
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
