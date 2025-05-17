import 'dart:convert';

import 'package:brinquedo_track/models/daily_sale_model.dart';
import 'package:brinquedo_track/models/highlight_model.dart';
import 'package:brinquedo_track/services/http_request.dart';
import 'package:brinquedo_track/services/monitoring_service.dart';

abstract class BaseStatsService {
  Future<List<HighlightModel>> topCustomers();

  Future<List<DailySaleModel>> dailySales();
}

class StatsService implements BaseStatsService {
  final BaseMonitoringService monitoringService;
  final BaseHttpRequest httpRequest;

  const StatsService({
    required this.monitoringService,
    required this.httpRequest,
  });

  static const String endpoint = 'stats';
  static const String endpointTopCustomers = 'top-clients';
  static const String endpointDailySales = 'daily-sales';

  @override
  Future<List<HighlightModel>> topCustomers() async {
    try {
      final response = await httpRequest.get(
        endpoint: '$endpoint/$endpointTopCustomers',
      );

      final json = jsonDecode(response);

      final rawList = List<Map<String, dynamic>>.from(json['highlights'] ?? []);

      return rawList.map(HighlightModel.fromJson).toList();
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<DailySaleModel>> dailySales() async {
    try {
      final response = await httpRequest.get(
        endpoint: '$endpoint/$endpointDailySales',
      );

      final json = jsonDecode(response);

      final rawList = List<Map<String, dynamic>>.from(json);

      return rawList.map(DailySaleModel.fromJson).toList();
    } catch (e, stackTrace) {
      monitoringService.errorLogger(e, stackTrace);
      return [];
    }
  }
}
