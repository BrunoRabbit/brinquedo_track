import 'package:brinquedo_track/pages/login/bloc/login_bloc.dart';
import 'package:brinquedo_track/routes/routes.dart';
import 'package:brinquedo_track/widgets/app_primary_button.dart';
import 'package:brinquedo_track/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.go(AppRoutes.homeRoute);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: formKey,
            child: Padding(
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
                        label: 'Entrar',
                      ),
                    ],
                  ),
                  const Center(
                    child: Text('ou'),
                  ),
                  Row(
                    children: [
                      AppPrimaryButton(
                        color: Colors.indigo,
                        onTap: () {
                          context.push(AppRoutes.signUpRoute);
                        },
                        label: 'Registrar',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final email = emailEC.text;
    final password = passwordEC.text;

    await context.read<LoginBloc>().login(
          email: email,
          password: password,
        );
  }
}
