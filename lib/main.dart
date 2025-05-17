import 'package:brinquedo_track/injector/app_injector.dart';
import 'package:brinquedo_track/pages/home/bloc/home_bloc.dart';
import 'package:brinquedo_track/pages/login/bloc/login_bloc.dart';
import 'package:brinquedo_track/pages/root/bloc/root_bloc.dart';
import 'package:brinquedo_track/pages/signup/bloc/sign_up_bloc.dart';
import 'package:brinquedo_track/pages/stats/bloc/stats_bloc.dart';
import 'package:brinquedo_track/theme/base_color.dart';
import 'package:brinquedo_track/theme/base_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const AppInjector().inject();
}

class AppInitializer extends StatefulWidget {
  final BaseTheme theme;

  const AppInitializer({
    required this.theme,
    super.key,
  });

  static BrinquedoTrackProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BrinquedoTrackProvider>()!;
  }

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.noScaling,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          bannerTheme: const MaterialBannerThemeData(
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<RootBloc>(
              create: (_) => GetIt.I.get(),
            ),
            BlocProvider<LoginBloc>(
              create: (_) => GetIt.I.get(),
            ),
            BlocProvider<SignUpBloc>(
              create: (_) => GetIt.I.get(),
            ),
            BlocProvider<HomeBloc>(
              create: (_) => GetIt.I.get(),
            ),
            BlocProvider<StatsBloc>(
              create: (_) => GetIt.I.get(),
            ),
          ],
          child: BrinquedoTrackProvider(
            materialApp: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: GetIt.I.get(),
              locale: const Locale('pt', 'BR'),
              supportedLocales: const [
                Locale('pt', 'BR'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: createtThemeData(widget.theme.colors),
            ),
            theme: widget.theme,
          ),
        ),
      ),
    );
  }

  ThemeData createtThemeData(BaseColorTheme colors) {
    return ThemeData();
  }
}

class BrinquedoTrackProvider extends InheritedWidget {
  final MaterialApp materialApp;
  final BaseTheme theme;

  const BrinquedoTrackProvider({
    required this.materialApp,
    required this.theme,
    super.key,
  }) : super(child: materialApp);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
