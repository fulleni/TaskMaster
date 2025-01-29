UserPreferencesRepository is a Dart package that manages user preferences such as theme mode, accent color, font size, font family, and language settings.

## Features

- Set and get theme mode
- Set and get theme accent color
- Set and get title font size
- Set and get body font size
- Set and get font family
- Set and get language
- Reset all preferences to default values
- Stream all preferences at once

## Getting started

To use this package, add `user_preferences_repository` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  user_preferences_repository: ^1.0.0
```

## Usage

Here are some examples of how to use the UserPreferencesRepository:

```dart
import 'package:user_preferences_client/user_preferences_client.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

void main() async {
  final client = UserPreferencesClient();
  final repository = UserPreferencesRepository(client: client);

  // Set theme mode
  await repository.setThemeMode(UserPreferenceThemeMode.dark);

  // Get theme mode
  final themeMode = await repository.getThemeMode();
  print('Current theme mode: $themeMode');

  // Set accent color
  await repository.setThemeAccentColor(UserPreferenceAccentColor.blue);

  // Get accent color
  final accentColor = await repository.getThemeAccentColor();
  print('Current accent color: $accentColor');

  // Reset preferences
  await repository.resetPreferences();
}
```

## Additional information

For more information, visit the [documentation](https://example.com/docs). To contribute, please see the [contributing guidelines](https://example.com/contributing). If you encounter any issues, please file them [here](https://example.com/issues). The package authors will respond as soon as possible.
