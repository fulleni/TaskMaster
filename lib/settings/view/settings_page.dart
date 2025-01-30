import 'package:flutter/material.dart';
import 'package:taskmaster/font_settings/view/font_settings_page.dart';
import 'package:taskmaster/theme_settings/view/theme_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor =
        theme.brightness == Brightness.light ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: textColor)),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Theme', style: TextStyle(color: textColor)),
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
            title: Text('Font', style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FontSettingsPage()),
              );
            },
          ),
          ListTile(
            title: Text('About', style: TextStyle(color: textColor)),
            onTap: () {
              showAboutDialog(
                context: context,
                // applicationIcon: const Icon(Icons.task),
                // applicationName: 'TaskMaster',
                applicationVersion: '0.13.0',
                children: [
                  Text(
                    'TaskMaster is a user-friendly task management application built to help you stay organized and productive.',
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
