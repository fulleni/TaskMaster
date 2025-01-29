Handles all user preferences for the client side of the application

## Features

- Toggle theme mode between light, dark, and system.
- Change the main accent color of the theme.

## Getting started

To start using the package, add it to your `pubspec.yaml`:

```yaml
dependencies:
  user_preferences_client:
    path: ../user_preferences_client
```

## Usage

Include the `UserPreferencesClient` in your project:

```dart
import 'package:user_preferences_client/user_preferences_client.dart';

class MyUserPreferencesClient extends UserPreferencesClient {
  @override
  Future<void> changeThemeMode(ThemeMode themeMode) async {
    // Implement your logic to change the theme mode
  }

  @override
  Future<void> changeThemeAccentColor(MaterialColor color) async {
    // Implement your logic to change the accent color
  }
}
```

## Additional information

For more information, contributions, or to file issues, please visit the repository. The package authors will respond to issues as soon as possible.
