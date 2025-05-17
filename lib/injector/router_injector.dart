import 'package:brinquedo_track/injector/base_injector.dart';
import 'package:brinquedo_track/models/customer_list_model.dart';
import 'package:brinquedo_track/pages/customer_form/customer_form_page.dart';
import 'package:brinquedo_track/pages/home/home_page.dart';
import 'package:brinquedo_track/pages/login/login_page.dart';
import 'package:brinquedo_track/pages/root/root_page.dart';
import 'package:brinquedo_track/pages/signup/sign_up_page.dart';
import 'package:brinquedo_track/pages/stats/stats_page.dart';
import 'package:brinquedo_track/routes/routes.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class RouterInjector implements BaseInjector {
  const RouterInjector();

  @override
  Future<void> inject() async {
    final getIt = GetIt.instance;

    getIt.registerFactory<List<RouteBase>>(
      () => [
        GoRoute(
          path: AppRoutes.baseRoute,
          builder: (context, state) {
            return getIt.get<RootPage>(
              instanceName: AppRoutes.baseRoute,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.homeRoute,
          builder: (context, state) {
            return getIt.get<HomePage>(
              instanceName: AppRoutes.homeRoute,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.loginRoute,
          builder: (context, state) {
            return getIt.get<LoginPage>(
              instanceName: AppRoutes.loginRoute,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.signUpRoute,
          builder: (context, state) {
            return getIt.get<SignUpPage>(
              instanceName: AppRoutes.signUpRoute,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.customerFormPageRoute,
          builder: (context, state) {
            final extra = (state.extra as CustomerListModel?);

            return CustomerFormPage(
              customerModel: extra,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.statsPageRoute,
          builder: (context, state) {
            return getIt.get<StatsPage>(
              instanceName: AppRoutes.statsPageRoute,
            );
          },
        ),
      ],
    );
  }
}
