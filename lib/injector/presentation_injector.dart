import 'package:brinquedo_track/injector/base_injector.dart';
import 'package:brinquedo_track/pages/customer_form/customer_form_page.dart';
import 'package:brinquedo_track/pages/home/bloc/home_bloc.dart';
import 'package:brinquedo_track/pages/home/home_page.dart';
import 'package:brinquedo_track/pages/login/bloc/login_bloc.dart';
import 'package:brinquedo_track/pages/login/login_page.dart';
import 'package:brinquedo_track/pages/root/bloc/root_bloc.dart';
import 'package:brinquedo_track/pages/root/root_page.dart';
import 'package:brinquedo_track/pages/signup/bloc/sign_up_bloc.dart';
import 'package:brinquedo_track/pages/signup/sign_up_page.dart';
import 'package:brinquedo_track/pages/stats/bloc/stats_bloc.dart';
import 'package:brinquedo_track/pages/stats/stats_page.dart';
import 'package:brinquedo_track/routes/routes.dart';
import 'package:get_it/get_it.dart';

class PresentationInjector implements BaseInjector {
  const PresentationInjector();

  @override
  Future<void> inject() async {
    final getIt = GetIt.instance;

    getIt
      ..allowReassignment = true
      ..registerFactory<RootPage>(
        RootPage.new,
        instanceName: AppRoutes.baseRoute,
      )
      ..registerFactory<HomePage>(
        () => HomePage(
          themeRepository: getIt.get(),
        ),
        instanceName: AppRoutes.homeRoute,
      )
      ..registerFactory<HomeBloc>(
        () => HomeBloc(
          customerRepository: getIt.get(),
          sessionRepository: getIt.get(),
          monitoringService: getIt.get(),
        ),
      )
      ..registerFactory<LoginPage>(
        LoginPage.new,
        instanceName: AppRoutes.loginRoute,
      )
      ..registerFactory<RootBloc>(
        () => RootBloc(
          sessionRepository: getIt.get(),
          monitoringService: getIt.get(),
          authService: getIt.get(),
        ),
      )
      ..registerFactory<LoginBloc>(
        () => LoginBloc(
          sessionRepository: getIt.get(),
          monitoringService: getIt.get(),
          authService: getIt.get(),
        ),
      )
      ..registerFactory<SignUpBloc>(
        () => SignUpBloc(
          sessionRepository: getIt.get(),
          monitoringService: getIt.get(),
          authService: getIt.get(),
        ),
      )
      ..registerFactory<SignUpPage>(
        () => SignUpPage(
          monitoringService: getIt.get(),
        ),
        instanceName: AppRoutes.signUpRoute,
      )
      ..registerFactory<CustomerFormPage>(
        () => CustomerFormPage(
          customerModel: getIt.get(),
        ),
        instanceName: AppRoutes.customerFormPageRoute,
      )
      ..registerFactory<StatsPage>(
        StatsPage.new,
        instanceName: AppRoutes.statsPageRoute,
      )
      ..registerFactory<StatsBloc>(
        () => StatsBloc(
          monitoringService: getIt.get(),
          statsRepository: getIt.get(),
        ),
      );
  }
}
