import 'package:brinquedo_track/storage/local_storage_interface.dart';
import 'package:brinquedo_track/theme/base_theme.dart';

abstract class BaseThemeRepository {
  Future<void> setTheme(ThemeMode mode);
  Future<ThemeMode> getTheme();
}

class ThemeRepository implements BaseThemeRepository {
  final LocalStorageInterface localStorage;

  const ThemeRepository({
    required this.localStorage,
  });

  static const String themeKey = 'themeKey';

  @override
  Future<ThemeMode> getTheme() async {
    final theme = await localStorage.getString(themeKey);

    return ThemeModeExtension.fromString(theme ?? 'light');
  }

  @override
  Future<void> setTheme(ThemeMode mode) async {
    await localStorage.setString(themeKey, mode.name);
  }
}
