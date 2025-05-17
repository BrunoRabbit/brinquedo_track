// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:brinquedo_track/interfaces/base_bloc.dart';
import 'package:meta/meta.dart';

import 'package:brinquedo_track/repository/session_repository.dart';
import 'package:brinquedo_track/services/auth_service.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';

part 'sign_up_state.dart';

class SignUpBloc extends BaseBloc<SignUpState> {
  final BaseSessionRepository sessionRepository;
  final BaseAuthService authService;
  final BaseMonitoringService monitoringService;

  SignUpBloc({
    required this.sessionRepository,
    required this.authService,
    required this.monitoringService,
  }) : super(AppInitial());

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(AppLoading());

    try {
      final register = await sessionRepository.register(
        email: email,
        password: password,
      );

      if (register != null) {
        emit(SignUpSuccess());
        return;
      }

      emit(SignUpFailure());
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      emit(SignUpFailure());
    }
  }
}
