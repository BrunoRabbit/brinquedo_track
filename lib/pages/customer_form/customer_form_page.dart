// ignore_for_file: use_build_context_synchronously

import 'package:brinquedo_track/models/customer_list_model.dart';
import 'package:brinquedo_track/pages/home/bloc/home_bloc.dart';
import 'package:brinquedo_track/widgets/app_primary_button.dart';
import 'package:brinquedo_track/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CustomerFormPage extends StatefulWidget {
  const CustomerFormPage({
    required this.customerModel,
    super.key,
  });

  final CustomerListModel? customerModel;

  @override
  State<CustomerFormPage> createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final birthDateEC = TextEditingController();

  CustomerListModel? get customerModel => widget.customerModel;

  @override
  void initState() {
    super.initState();
    if (widget.customerModel != null) {
      nameEC.text = customerModel!.name;
      emailEC.text = customerModel!.email;
      birthDateEC.text =
          DateFormat('yyyy-MM-dd').format(customerModel!.birthDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            AppTextField(
              label: 'Name',
              controller: nameEC,
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              label: 'Email',
              controller: emailEC,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                selectDate(context);
              },
              child: AbsorbPointer(
                child: AppTextField(
                  label: birthDateEC.text.isEmpty
                      ? 'Data de aniversário'
                      : birthDateEC.text,
                  readOnly: true,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        child: Row(
          children: [
            AppPrimaryButton(
              label: customerModel == null ? 'Criar cliente' : 'Editar cliente',
              onTap: () async {
                bool updatedOrCreated = false;

                if (customerModel == null) {
                  updatedOrCreated =
                      await context.read<HomeBloc>().createCustomer(
                            name: nameEC.text,
                            email: emailEC.text,
                            birthDate: birthDateEC.text,
                          );
                } else {
                  updatedOrCreated =
                      await context.read<HomeBloc>().editCustomer(
                            name: nameEC.text,
                            email: emailEC.text,
                            birthDate: birthDateEC.text,
                            oldEmail: customerModel!.email,
                          );
                }

                if (updatedOrCreated) {
                  await Future.microtask(
                    () => context.pop(true),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (datePicked != null) {
      setState(() {
        birthDateEC.text = DateFormat('yyyy-MM-dd').format(datePicked);
      });
    }
  }
}
