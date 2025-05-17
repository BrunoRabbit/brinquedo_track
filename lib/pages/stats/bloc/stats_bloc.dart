// ignore_for_file: depend_on_referenced_packages

import 'package:brinquedo_track/models/daily_sale_model.dart';
import 'package:brinquedo_track/models/highlight_model.dart';
import 'package:brinquedo_track/repository/stats_repository.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';
import 'package:brinquedo_track/interfaces/base_bloc.dart';

import 'package:meta/meta.dart';

part 'stats_state.dart';

class StatsBloc extends BaseBloc<StatsState> {
  final BaseStatsRepository statsRepository;
  final BaseMonitoringService monitoringService;

  StatsBloc({
    required this.statsRepository,
    required this.monitoringService,
  }) : super(StatsInitial());

  Future<void> loadAll() async {
    emit(StatsLoading());

    List<HighlightModel> highlights = [];
    List<DailySaleModel> dailySales = [];

    try {
      highlights = await statsRepository.topCustomers();
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
    }

    try {
      dailySales = await statsRepository.dailySales();
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
    }

    emit(StatsLoaded(
      highlights: highlights,
      dailySales: dailySales,
    ));
  }
}
