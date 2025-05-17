// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brinquedo_track/models/daily_sale_model.dart';
import 'package:brinquedo_track/models/highlight_model.dart';
import 'package:brinquedo_track/services/stats_service.dart';

abstract class BaseStatsRepository {
  Future<List<HighlightModel>> topCustomers();
  Future<List<DailySaleModel>> dailySales();
}

class StatsRepository implements BaseStatsRepository {
  const StatsRepository({
    required this.statsService,
  });

  final BaseStatsService statsService;

  @override
  Future<List<HighlightModel>> topCustomers() async =>
      statsService.topCustomers();

  @override
  Future<List<DailySaleModel>> dailySales() => statsService.dailySales();
}
