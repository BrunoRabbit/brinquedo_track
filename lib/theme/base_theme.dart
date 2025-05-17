import 'package:brinquedo_track/theme/base_color.dart';
import 'package:brinquedo_track/theme/dark_color_theme.dart';
import 'package:brinquedo_track/theme/light_color_theme.dart';

enum ThemeMode {
  light,
  dark;
}

extension ThemeModeExtension on ThemeMode {
  String get name => toString().split('.').last;

  static ThemeMode fromString(String value) {
    return ThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ThemeMode.light,
    );
  }
}

class BaseTheme {
  final ThemeMode mode;
  final BaseColorTheme colors;

  const BaseTheme._({
    required this.colors,
    this.mode = ThemeMode.light,
  });

  factory BaseTheme.of(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => const BaseTheme._(
          colors: LightColorTheme(),
        ),
      ThemeMode.dark => const BaseTheme._(
          mode: ThemeMode.dark,
          colors: DarkColorTheme(),
        ),
    };
  }
}
