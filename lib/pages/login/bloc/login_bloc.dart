// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:brinquedo_track/interfaces/base_bloc.dart';
import 'package:meta/meta.dart';

import 'package:brinquedo_track/repository/session_repository.dart';
import 'package:brinquedo_track/services/auth_service.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';

part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginState> {
  final BaseSessionRepository sessionRepository;
  final BaseAuthService authService;
  final BaseMonitoringService monitoringService;

  LoginBloc({
    required this.sessionRepository,
    required this.authService,
    required this.monitoringService,
  }) : super(AppInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AppLoading());

    try {
      final login = await sessionRepository.login(
        email: email,
        password: password,
      );

      if (login != null) {
        emit(LoginSuccess());
        return;
      }

      emit(LoginFailure());
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      emit(LoginFailure());
    }
  }
}
