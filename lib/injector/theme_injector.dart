import 'package:brinquedo_track/injector/base_injector.dart';
import 'package:brinquedo_track/repository/theme_repository.dart';
import 'package:brinquedo_track/theme/base_theme.dart';
import 'package:get_it/get_it.dart';

class ThemeInjector implements BaseInjector {
  const ThemeInjector();

  @override
  Future<void> inject() async {
    final getIt = GetIt.instance;

    final repository = getIt.get<BaseThemeRepository>();

    final themeMode = await repository.getTheme();

    getIt.registerLazySingleton<BaseTheme>(
      () => BaseTheme.of(themeMode),
    );
  }
}
