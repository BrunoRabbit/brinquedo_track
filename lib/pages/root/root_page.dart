import 'package:brinquedo_track/pages/root/bloc/root_bloc.dart';
import 'package:brinquedo_track/pages/splash/splash_page.dart';
import 'package:brinquedo_track/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<RootBloc, RootState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go(AppRoutes.homeRoute);
            return;
          }

          if (state is Unauthenticated) {
            context.replace(AppRoutes.loginRoute);
            return;
          }
        },
        child: SplashPage(
          loadingFuture: () async {
            await context.read<RootBloc>().startApp();
          },
        ),
      ),
    );
  }
}
