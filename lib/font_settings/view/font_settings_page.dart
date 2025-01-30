import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmaster/font_settings/bloc/font_settings_bloc.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fontSettings),
      ),
      body: BlocBuilder<FontSettingsBloc, FontSettingsState>(
        builder: (context, state) {
          switch (state.status) {
            case FontSettingsStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case FontSettingsStatus.failure:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.failedToLoadFontSettings,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () => context
                                .read<FontSettingsBloc>()
                                .add(LoadFontSettings()),
                            icon: const Icon(Icons.refresh),
                            label: Text(l10n.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            case FontSettingsStatus.success:
            case FontSettingsStatus.initial:
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
                          l10n.fontFamily,
                          style: TextStyle(color: textColor),
                        ),
                        DropdownButton<UserPreferenceFontFamily>(
                          value: state.fontFamily,
                          hint: Text(l10n.selectFontFamily,
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
                          l10n.fontSize,
                          style: TextStyle(color: textColor),
                        ),
                        DropdownButton<UserPreferenceFontSize>(
                          value: state.fontSize,
                          hint: Text(l10n.selectFontSize,
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
