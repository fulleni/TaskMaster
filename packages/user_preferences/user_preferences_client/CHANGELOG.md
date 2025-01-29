## 0.1.0

- Initial release.
- Added `UserPreferencesClient` abstract class with methods for:
  - Changing the theme mode (light, dark, or system).
  - Changing the main accent color of the theme.

## 0.2.0

- Added methods to `UserPreferencesClient` for:
  - Setting and getting the title font size.
  - Setting and getting the body font size.
  - Setting and getting the font family.
  - Setting and getting the language.

## 0.3.0

- Added validation to `UserPreferences` to ensure values are within acceptable ranges.
- Added a method to reset preferences to default values in `UserPreferences`.
- Added a method to update individual preferences in `UserPreferences`.
- Added a method to compare two `UserPreferences` instances.
- Changed the `themeMode` parameter in `setThemeMode` to a local enum.
- Changed the `color` parameter in `setThemeAccentColor` to a local enum with 3 colors suitable for a dark grey background.
