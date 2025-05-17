import 'dart:convert';

import 'package:brinquedo_track/models/session_model.dart';
import 'package:brinquedo_track/services/http_request.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';

abstract class BaseAuthService {
  Future<SessionModel?> login({
    required String email,
    required String password,
  });
  Future<SessionModel?> register({
    required String email,
    required String password,
  });
}

class AuthService implements BaseAuthService {
  final BaseMonitoringService monitoringService;
  final BaseHttpRequest httpRequest;

  const AuthService({
    required this.monitoringService,
    required this.httpRequest,
  });

  static const String endpoint = 'auth';
  static const String endpointLogin = 'login';
  static const String endpointRegister = 'register';

  @override
  Future<SessionModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await httpRequest.post(
        authType: AuthType.none,
        endpoint: '$endpoint/$endpointLogin',
        body: {
          'email': email,
          'password': password,
        },
      );

      return SessionModel.fromJson(response);
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return null;
    }
  }

  @override
  Future<SessionModel?> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await httpRequest.post(
        endpoint: '$endpoint/$endpointRegister',
        authType: AuthType.none,
        body: {
          'email': email,
          'password': password,
        },
      );

      return SessionModel.fromJson(jsonDecode(response));
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return null;
    }
  }
}
