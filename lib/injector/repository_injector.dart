import 'package:brinquedo_track/injector/base_injector.dart';
import 'package:brinquedo_track/repository/customer_repository.dart';
import 'package:brinquedo_track/repository/session_repository.dart';
import 'package:brinquedo_track/repository/stats_repository.dart';
import 'package:brinquedo_track/repository/theme_repository.dart';
import 'package:get_it/get_it.dart';

class RepositoryInjector implements BaseInjector {
  const RepositoryInjector();

  @override
  Future<void> inject() async {
    final getIt = GetIt.instance;

    GetIt.instance
      ..registerFactory<BaseThemeRepository>(
        () => ThemeRepository(
          localStorage: getIt.get(),
        ),
      )
      ..registerFactory<BaseSessionRepository>(
        () => SessionRepository(
          getIt: getIt,
          localStorage: getIt.get(),
          secureStorage: getIt.get(),
          authService: getIt.get(),
        ),
      )
      ..registerFactory<BaseCustomerRepository>(
        () => CustomerRepository(
          customerService: getIt.get(),
        ),
      )
      ..registerFactory<BaseStatsRepository>(
        () => StatsRepository(
          statsService: getIt.get(),
        ),
      );
  }
}
