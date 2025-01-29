import 'package:flutter/material.dart';
import 'package:taskmaster/font_settings/view/font_settings_page.dart';
import 'package:taskmaster/theme_settings/view/theme_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme Settings'),
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
            title: const Text('Font Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FontSettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
