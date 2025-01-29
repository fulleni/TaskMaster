Handles all user preferences for the client side of the application

## Features

- Set and get the theme mode.
- Set and get the theme accent color.
- Set and get the title font size.
- Set and get the body font size.
- Set and get the font family.
- Set and get the language.
- Validate preferences to ensure values are within acceptable ranges.
- Reset preferences to default values.
- Update individual preferences.
- Compare two `UserPreferences` instances.

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
  Future<void> setThemeMode(UserPreferenceThemeMode themeMode) async {
    // Implement your logic to change the theme mode
  }

  @override
  Future<void> setThemeAccentColor(UserPreferenceAccentColor color) async {
    // Implement your logic to change the accent color
  }

  @override
  Future<void> setTitleFontSize(UserPreferenceFontSize fontSize) async {
    // Implement your logic to set the title font size
  }

  @override
  Future<void> setBodyFontSize(UserPreferenceFontSize fontSize) async {
    // Implement your logic to set the body font size
  }

  @override
  Future<void> setFontFamily(UserPreferenceGoogleFontsFamily fontFamily) async {
    // Implement your logic to set the font family
  }

  @override
  Future<void> setLanguage(UserPreferenceLanguage language) async {
    // Implement your logic to set the language
  }

  @override
  Future<UserPreferenceThemeMode> getThemeMode() async {
    // Implement your logic to get the theme mode
  }

  @override
  Future<UserPreferenceAccentColor> getThemeAccentColor() async {
    // Implement your logic to get the accent color
  }

  @override
  Future<UserPreferenceFontSize> getTitleFontSize() async {
    // Implement your logic to get the title font size
  }

  @override
  Future<UserPreferenceFontSize> getBodyFontSize() async {
    // Implement your logic to get the body font size
  }

  @override
  Future<UserPreferenceGoogleFontsFamily> getFontFamily() async {
    // Implement your logic to get the font family
  }

  @override
  Future<UserPreferenceLanguage> getLanguage() async {
    // Implement your logic to get the language
  }
}
```

## Additional information

For more information, contributions, or to file issues, please visit the repository. The package authors will respond to issues as soon as possible.
