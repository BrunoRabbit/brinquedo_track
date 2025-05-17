import 'package:brinquedo_track/injector/base_injector.dart';
import 'package:brinquedo_track/services/auth_service.dart';
import 'package:brinquedo_track/services/customer_service.dart';
import 'package:brinquedo_track/services/http_request.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';
import 'package:brinquedo_track/services/stats_service.dart';
import 'package:get_it/get_it.dart';

class ServiceInjector implements BaseInjector {
  const ServiceInjector();

  @override
  Future<void> inject() async {
    final getIt = GetIt.instance;

    getIt
      ..registerFactory<BaseMonitoringService>(
        () => const MonitoringService(),
      )
      ..registerFactory<BaseHttpRequest>(
        () => HttpRequest(
          monitoringService: getIt.get(),
          secureStorage: getIt.get(),
        ),
      )
      ..registerFactory<BaseAuthService>(
        () => AuthService(
          monitoringService: getIt.get(),
          httpRequest: getIt.get(),
        ),
      )
      ..registerFactory<BaseCustomerService>(
        () => CustomerService(
          monitoringService: getIt.get(),
          httpRequest: getIt.get(),
        ),
      )
      ..registerFactory<BaseStatsService>(
        () => StatsService(
          monitoringService: getIt.get(),
          httpRequest: getIt.get(),
        ),
      );
  }
}
