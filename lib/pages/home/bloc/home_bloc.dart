// ignore: depend_on_referenced_packages
import 'package:brinquedo_track/models/customer_list_model.dart';
import 'package:meta/meta.dart';

import 'package:brinquedo_track/interfaces/base_bloc.dart';
import 'package:brinquedo_track/repository/customer_repository.dart';
import 'package:brinquedo_track/repository/session_repository.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';

part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  final BaseCustomerRepository customerRepository;
  final BaseSessionRepository sessionRepository;
  final BaseMonitoringService monitoringService;

  HomeBloc({
    required this.customerRepository,
    required this.monitoringService,
    required this.sessionRepository,
  }) : super(AppInitial());

  Future<List<CustomerListModel>?> fetchCustomer() async {
    emit(AppLoading());

    try {
      final customers = await customerRepository.fetchCustomer();
      emit(
        FetchedSuccess(customers: customers),
      );

      return customers;
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      emit(
        FetchedFailed(error: e.toString()),
      );
      return [];
    }
  }

  Future<bool> editCustomer({
    required String name,
    required String email,
    required String oldEmail,
    required String birthDate,
  }) async {
    try {
      final isCustomerCreated = await customerRepository.editCustomer(
        name: name,
        email: email,
        birthDate: birthDate,
        oldEmail: oldEmail,
      );

      return isCustomerCreated != null;
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return false;
    }
  }

  Future<bool> createCustomer({
    required String name,
    required String email,
    required String birthDate,
  }) async {
    emit(AppLoading());

    try {
      final isCustomerCreated = await customerRepository.createCustomer(
        name: name,
        email: email,
        birthDate: birthDate,
      );

      return isCustomerCreated != null;
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return false;
    }
  }

  Future<void> logout() async {
    emit(AppLoading());

    try {
      await sessionRepository.logout();
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
    }
  }

  Future<bool> deleteCustomer(String email) async {
    try {
      final isCustomerDeleted = await customerRepository.deleteCustomer(email);

      return isCustomerDeleted;
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return false;
    }
  }
}
