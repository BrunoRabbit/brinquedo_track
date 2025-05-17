import 'package:brinquedo_track/injector/base_injector.dart';
import 'package:brinquedo_track/injector/presentation_injector.dart';
import 'package:brinquedo_track/injector/repository_injector.dart';
import 'package:brinquedo_track/injector/router_injector.dart';
import 'package:brinquedo_track/injector/service_injector.dart';
import 'package:brinquedo_track/injector/storage_injector.dart';
import 'package:brinquedo_track/injector/theme_injector.dart';
import 'package:brinquedo_track/main.dart';
import 'package:brinquedo_track/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AppInjector implements BaseInjector {
  const AppInjector();

  @override
  Future<void> inject() async {
    final getIt = GetIt.instance;

    await const StorageInjector().inject();

    await const ServiceInjector().inject();
    await const RepositoryInjector().inject();
    await const ThemeInjector().inject();
    await const RouterInjector().inject();
    await const PresentationInjector().inject();

    getIt.registerLazySingleton<RouterConfig<Object>>(
      () => GoRouter(
        routes: getIt.get(),
        initialLocation: AppRoutes.baseRoute,
      ),
    );

    runApp(
      AppInitializer(
        theme: getIt.get(),
      ),
    );
  }
}
