import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taskmaster/font_settings/view/font_settings_page.dart';
import 'package:taskmaster/language_setting/view/language_setting_page.dart';
import 'package:taskmaster/theme_settings/view/theme_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final textColor =
        theme.brightness == Brightness.light ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings, style: TextStyle(color: textColor)),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(l10n.theme, style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(l10n.font, style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FontSettingsPage()),
              );
            },
          ),
          ListTile(
            title: Text(l10n.language, style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LanguageSettingPage()),
              );
            },
          ),
          ListTile(
            title: Text(l10n.about, style: TextStyle(color: textColor)),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationVersion: '0.13.0',
                children: [
                  Text(
                    l10n.aboutDescription,
                    style: TextStyle(color: textColor),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
