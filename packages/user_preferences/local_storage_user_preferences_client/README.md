# local_storage_user_preferences_client

A UserPreferencesClient implementation that uses the local storage.

## Features

- Store user preferences locally
- Retrieve user preferences
- Delete user preferences

## Getting started

To start using this package, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  local_storage_user_preferences_client:
    path: ../local_storage_user_preferences_client
```

## Usage

Here is a simple example of how to use the package:

```dart
import 'package:local_storage_user_preferences_client/local_storage_user_preferences_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final client = LocalStorageUserPreferencesClient(sharedPreferences: sharedPreferences);

  await client.setThemeMode(UserPreferenceThemeMode.dark);
  final themeMode = await client.getThemeMode();
  print('Current theme mode: $themeMode');
}
```

## Additional information

For more information, visit the [repository](https://github.com/your-repo/local_storage_user_preferences_client). To contribute, please submit a pull request. For issues, open a ticket on the repository. Expect responses within 48 hours.
