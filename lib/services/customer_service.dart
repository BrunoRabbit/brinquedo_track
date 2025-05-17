import 'dart:convert';

import 'package:brinquedo_track/models/customer_list_model.dart';
import 'package:brinquedo_track/models/customer_model.dart';
import 'package:brinquedo_track/services/http_request.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';

abstract class BaseCustomerService {
  Future<List<CustomerListModel>> fetchCustomers();

  Future<CustomerModel?> createCustomer({
    required String name,
    required String email,
    required String birthDate,
  });

  Future<CustomerModel?> editCustomer({
    required String name,
    required String email,
    required String oldEmail,
    required String birthDate,
  });

  Future<bool> deleteCustomer(String email);
}

class CustomerService implements BaseCustomerService {
  final BaseMonitoringService monitoringService;
  final BaseHttpRequest httpRequest;

  const CustomerService({
    required this.monitoringService,
    required this.httpRequest,
  });

  static const String endpoint = 'customers';
  static const String endpointCustomer = 'customer';

  @override
  Future<List<CustomerListModel>> fetchCustomers() async {
    try {
      final response = await httpRequest.get(
        endpoint: endpoint,
      );
      final json = jsonDecode(response);

      final rawList = List<Map<String, dynamic>>.from(
        json['data']['clientes'] ?? [],
      );

      return rawList.map(CustomerListModel.fromJson).toList();
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return [];
    }
  }

  @override
  Future<CustomerModel?> createCustomer({
    required String name,
    required String email,
    required String birthDate,
  }) async {
    try {
      final response = await httpRequest.post(
        endpoint: endpointCustomer,
        body: {
          'name': name,
          'email': email,
          'birthDate': birthDate,
        },
      );

      return CustomerModel.fromJson(jsonDecode(response));
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return null;
    }
  }

  @override
  Future<bool> deleteCustomer(String email) async {
    try {
      final response = await httpRequest.delete(
        endpoint: '$endpointCustomer/$email',
        body: {},
      );

      final json = jsonDecode(response);

      return json['success'] ?? false;
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return false;
    }
  }

  @override
  Future<CustomerModel?> editCustomer({
    required String name,
    required String email,
    required String oldEmail,
    required String birthDate,
  }) async {
    try {
      final response = await httpRequest.put(
        endpoint: endpointCustomer,
        body: {
          'name': name,
          'newEmail': email,
          'oldEmail': oldEmail,
          'birthDate': birthDate,
        },
      );

      return CustomerModel.fromJson(jsonDecode(response));
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return null;
    }
  }
}
