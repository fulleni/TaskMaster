import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';
import '../bloc/language_setting_bloc.dart';

class LanguageSettingPage extends StatelessWidget {
  const LanguageSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageSettingBloc(
        userPreferencesRepository: context.read<UserPreferencesRepository>(),
      )..add(LoadLanguageSettings()),
      child: const _LanguageSettingView(),
    );
  }
}

class _LanguageSettingView extends StatelessWidget {
  const _LanguageSettingView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<LanguageSettingBloc, LanguageSettingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.languageSettings),
          ),
          body: switch (state.status) {
            Status.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            Status.failure => Center(
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
                            l10n.failedToLoadLanguageSettings,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () => context
                                .read<LanguageSettingBloc>()
                                .add(LoadLanguageSettings()),
                            icon: const Icon(Icons.refresh),
                            label: Text(l10n.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            _ => ListView(
                children: [
                  RadioListTile<String>(
                    title: Text(l10n.englishLanguage),
                    value: 'english',
                    groupValue: state.language,
                    onChanged: (value) {
                      context
                          .read<LanguageSettingBloc>()
                          .add(UpdateLanguage(value!));
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(l10n.arabicLanguage),
                    value: 'arabic',
                    groupValue: state.language,
                    onChanged: (value) {
                      context
                          .read<LanguageSettingBloc>()
                          .add(UpdateLanguage(value!));
                    },
                  ),
                  if (state.status == Status.failure)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.errorMessage ?? l10n.failedToLoadLanguageSettings,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                ],
              ),
          },
        );
      },
    );
  }
}
