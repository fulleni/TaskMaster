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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButton<UserPreferenceFontSize>(
                    value: state.titleFontSize,
                    hint: const Text('Select Title Font Size'),
                    items: UserPreferenceFontSize.values.map((fontSize) {
                      return DropdownMenuItem(
                        value: fontSize,
                        child: Text(fontSize.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (fontSize) {
                      if (fontSize != null) {
                        context
                            .read<FontSettingsBloc>()
                            .add(UpdateTitleFontSize(fontSize));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButton<UserPreferenceFontSize>(
                    value: state.bodyFontSize,
                    hint: const Text('Select Body Font Size'),
                    items: UserPreferenceFontSize.values.map((fontSize) {
                      return DropdownMenuItem(
                        value: fontSize,
                        child: Text(fontSize.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (fontSize) {
                      if (fontSize != null) {
                        context
                            .read<FontSettingsBloc>()
                            .add(UpdateBodyFontSize(fontSize));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButton<UserPreferenceGoogleFontsFamily>(
                    value: state.fontFamily,
                    hint: const Text('Select Font Family'),
                    items: UserPreferenceGoogleFontsFamily.values
                        .map((fontFamily) {
                      return DropdownMenuItem(
                        value: fontFamily,
                        child: Text(fontFamily.toString().split('.').last),
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
            );
          }
        },
      ),
    );
  }
}
