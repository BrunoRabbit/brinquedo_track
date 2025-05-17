// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brinquedo_track/models/customer_list_model.dart';
import 'package:brinquedo_track/models/customer_model.dart';
import 'package:brinquedo_track/services/customer_service.dart';

abstract class BaseCustomerRepository {
  Future<CustomerModel?> createCustomer({
    required String name,
    required String email,
    required String birthDate,
  });
  Future<CustomerModel?> editCustomer({
    required String name,
    required String email,
    required String birthDate,
    required String oldEmail,
  });

  Future<List<CustomerListModel>?> fetchCustomer();
  Future<bool> deleteCustomer(String email);
}

class CustomerRepository implements BaseCustomerRepository {
  final BaseCustomerService customerService;

  const CustomerRepository({
    required this.customerService,
  });

  @override
  Future<CustomerModel?> createCustomer({
    required String name,
    required String email,
    required String birthDate,
  }) async =>
      await customerService.createCustomer(
        name: name,
        email: email,
        birthDate: birthDate,
      );

  @override
  Future<List<CustomerListModel>?> fetchCustomer() async =>
      await customerService.fetchCustomers();

  @override
  Future<bool> deleteCustomer(String email) async =>
      customerService.deleteCustomer(email);

  @override
  Future<CustomerModel?> editCustomer({
    required String name,
    required String email,
    required String birthDate,
    required String oldEmail,
  }) async =>
      customerService.editCustomer(
        name: name,
        email: email,
        birthDate: birthDate,
        oldEmail: oldEmail,
      );
}
