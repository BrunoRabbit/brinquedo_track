// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:brinquedo_track/models/login_model.dart';
import 'package:brinquedo_track/services/auth_service.dart';
import 'package:brinquedo_track/storage/local_storage_interface.dart';
import 'package:brinquedo_track/storage/secure_storage_interface.dart';
import 'package:get_it/get_it.dart';

abstract class BaseSessionRepository {
  Future<LoginModel?> login({
    required String email,
    required String password,
  });
  Future<LoginModel?> register({
    required String email,
    required String password,
  });
  Future<bool> currentSession();
  Future<bool> isLoggedIn();
  Future<void> getLogin();
  Future<void> logout();
}

class SessionRepository implements BaseSessionRepository {
  const SessionRepository({
    required this.localStorage,
    required this.secureStorage,
    required this.getIt,
    required this.authService,
  });

  final LocalStorageInterface localStorage;
  final SecureStorageInterface secureStorage;
  final GetIt getIt;
  final BaseAuthService authService;

  static const String sessionKey = 'session';
  static const String bearerKey = 'bearer';
  static const String userKey = 'user';

  @override
  Future<bool> isLoggedIn() async {
    final session = await currentSession();

    if (!session) {
      return false;
    }

    final login = await getLogin();

    return login != null;
  }

  @override
  Future<bool> currentSession() async {
    final sessionId = await localStorage.getString(sessionKey);

    if (sessionId == null) {
      return false;
    }

    final sessionData = await secureStorage.getString(bearerKey);

    return sessionData != null && sessionData.isNotEmpty;
  }

  @override
  Future<LoginModel?> login({
    required String email,
    required String password,
  }) async {
    final session = await authService.login(
      email: email,
      password: password,
    );

    if (session == null) return null;

    await secureStorage.setString(bearerKey, session.token);
    await localStorage.setString(sessionKey, session.sessionId);
    await secureStorage.setString(userKey, jsonEncode(session.login.toJson()));

    if (getIt.isRegistered<LoginModel>()) {
      getIt.unregister<LoginModel>();
    }

    getIt.registerLazySingleton<LoginModel>(
      () => session.login,
    );

    return session.login;
  }

  @override
  Future<LoginModel?> register({
    required String email,
    required String password,
  }) async {
    final session = await authService.register(
      email: email,
      password: password,
    );

    if (session == null) return null;

    await secureStorage.setString(bearerKey, session.token);
    await localStorage.setString(sessionKey, session.sessionId);
    await secureStorage.setString(userKey, jsonEncode(session.login.toJson()));

    if (getIt.isRegistered<LoginModel>()) {
      getIt.unregister<LoginModel>();
    }

    getIt.registerLazySingleton<LoginModel>(() => session.login);

    return session.login;
  }

  @override
  Future<LoginModel?> getLogin() async {
    final registered = getIt.isRegistered<LoginModel>();

    if (registered) {
      return getIt.get<LoginModel>();
    }

    final userJson = await secureStorage.getString(userKey);

    if (userJson == null) {
      return null;
    }

    final user = LoginModel.fromJson(
      jsonDecode(userJson),
    );

    getIt.registerLazySingleton<LoginModel>(() => user);

    return user;
  }

  @override
  Future<void> logout() async {
    await secureStorage.removeKey(bearerKey);
    await secureStorage.removeKey(userKey);
    await localStorage.removeKey(sessionKey);

    if (getIt.isRegistered<LoginModel>()) {
      getIt.unregister<LoginModel>();
    }
  }
}
