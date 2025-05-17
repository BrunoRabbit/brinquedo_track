// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:brinquedo_track/pages/home/bloc/home_bloc.dart';
import 'package:brinquedo_track/repository/theme_repository.dart';
import 'package:brinquedo_track/routes/routes.dart';
import 'package:brinquedo_track/theme/base_theme.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.themeRepository,
    super.key,
  });

  final BaseThemeRepository themeRepository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ThemeMode theme;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().fetchCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await context.push(
                AppRoutes.customerFormPageRoute,
              );

              if (result == true) {
                context.read<HomeBloc>().fetchCustomer();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              context.push(
                AppRoutes.statsPageRoute,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<HomeBloc>().logout();
              context.pushReplacement(AppRoutes.loginRoute);
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is AppLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FetchedFailed) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is FetchedSuccess) {
            final customers = state.customers;

            if (customers == null || customers.isEmpty) {
              return const Center(
                child: Text('Nenhum cliente encontrado'),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      final customer = customers[index];

                      return ListTile(
                        key: ValueKey(customer.email),
                        tileColor: Colors.purple[100],
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    customer.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    final result = await context.push(
                                      AppRoutes.customerFormPageRoute,
                                      extra: customer,
                                    );

                                    if (result == true) {
                                      context.read<HomeBloc>().fetchCustomer();
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    final isDeleted = await context
                                        .read<HomeBloc>()
                                        .deleteCustomer(customer.email);

                                    if (isDeleted) {
                                      setState(() {
                                        customers.removeWhere(
                                          (c) => c.email == customer.email,
                                        );
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(width: 8),
                                const Text('Falta:'),
                                Text(
                                  customer.missingAlphabetLetter,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              customer.email,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // GestureDetector(
                //   child: Text('theme'),
                //   onTap: () async {
                //     await widget.themeRepository.setTheme(ThemeMode.dark);
                //     final _theme = await widget.themeRepository.getTheme();

                //     setState(() {
                //       theme = _theme;
                //     });
                //   },
                // ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
