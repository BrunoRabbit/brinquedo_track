// ignore_for_file: use_build_context_synchronously

import 'package:brinquedo_track/pages/signup/bloc/sign_up_bloc.dart';
import 'package:brinquedo_track/routes/routes.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';
import 'package:brinquedo_track/widgets/app_primary_button.dart';
import 'package:brinquedo_track/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  final BaseMonitoringService monitoringService;

  const SignUpPage({
    required this.monitoringService,
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Image.asset(
              'assets/images/horizontal_logo.png',
              height: 200,
            ),
            AppTextField(
              controller: emailEC,
              label: 'E-mail',
              hintText: 'Digite seu e-mail',
              keyboardType: TextInputType.emailAddress,
              action: TextInputAction.next,
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              controller: passwordEC,
              label: 'Senha',
              hintText: 'Digite sua senha',
              obscure: true,
              action: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                AppPrimaryButton(
                  onTap: submit,
                  label: 'Registrar',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submit() async {
    final email = emailEC.text;
    final password = passwordEC.text;

    try {
      await context.read<SignUpBloc>().register(
            email: email,
            password: password,
          );

      Future.delayed(
        Duration.zero,
        () => context.go(AppRoutes.homeRoute),
      );
    } catch (e, stackTrace) {
      widget.monitoringService.errorLogger(e, stackTrace);
    }
  }
}
