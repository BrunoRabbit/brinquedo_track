// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:brinquedo_track/interfaces/base_bloc.dart';
import 'package:meta/meta.dart';

import 'package:brinquedo_track/repository/session_repository.dart';
import 'package:brinquedo_track/services/auth_service.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';

part 'root_state.dart';

class RootBloc extends BaseBloc<RootState> {
  final BaseSessionRepository sessionRepository;
  final BaseAuthService authService;
  final BaseMonitoringService monitoringService;

  RootBloc({
    required this.sessionRepository,
    required this.authService,
    required this.monitoringService,
  }) : super(AppInitial());

  Future<void> startApp() async {
    emit(AppLoading());

    try {
      final isLogged = await sessionRepository.isLoggedIn();

      if (isLogged) {
        emit(Authenticated());
        return;
      }

      emit(Unauthenticated());
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
    }
  }
}
