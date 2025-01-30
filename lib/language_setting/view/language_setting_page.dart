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
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.languageSettings),
          ),
          body: ListView(
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
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.error!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
