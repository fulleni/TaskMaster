import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmaster/font_settings/bloc/font_settings_bloc.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

class FontSettingsPage extends StatelessWidget {
  const FontSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FontSettingsBloc(
        userPreferencesRepository: context.read<UserPreferencesRepository>(),
      )..add(LoadFontSettings()),
      child: const _FontSettingsView(),
    );
  }
}

class _FontSettingsView extends StatelessWidget {
  const _FontSettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Font Settings'),
      ),
      body: BlocBuilder<FontSettingsBloc, FontSettingsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.hasError) {
            return const Center(child: Text('Failed to load font settings'));
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
                        'Font Family',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      DropdownButton<UserPreferenceFontFamily>(
                        value: state.fontFamily,
                        hint: Text('Select Font Family',
                            style: TextStyle(color: textColor)),
                        items:
                            UserPreferenceFontFamily.values.map((fontFamily) {
                          return DropdownMenuItem(
                            value: fontFamily,
                            child: Text(fontFamily.toString().split('.').last,
                                style: TextStyle(color: textColor)),
                          );
                        }).toList(),
                        onChanged: (fontFamily) {
                          if (fontFamily != null) {
                            context
                                .read<FontSettingsBloc>()
                                .add(UpdateFontFamily(fontFamily));
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Font Size',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      DropdownButton<UserPreferenceFontSize>(
                        value: state.fontSize,
                        hint: Text('Select Font Size',
                            style: TextStyle(color: textColor)),
                        items: UserPreferenceFontSize.values.map((fontSize) {
                          return DropdownMenuItem(
                            value: fontSize,
                            child: Text(
                              UserPreferenceFontSizeX.toDisplayString(
                                fontSize,
                              ),
                              style: TextStyle(color: textColor),
                            ),
                          );
                        }).toList(),
                        onChanged: (fontSize) {
                          if (fontSize != null) {
                            context
                                .read<FontSettingsBloc>()
                                .add(UpdateFontSize(fontSize));
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
