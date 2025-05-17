import 'dart:developer';

import 'package:flutter/foundation.dart';

abstract class BaseMonitoringService {
  void logger(String text);

  /// [Object] 'e' is exception
  void errorLogger(Object e, StackTrace stackTrace);
}

class MonitoringService implements BaseMonitoringService {
  const MonitoringService();

  @override
  void errorLogger(Object exception, StackTrace stackTrace) {
    if (kReleaseMode) {
      //Sentry
    }
    log(exception.toString(), stackTrace: stackTrace);
  }

  @override
  void logger(String text) {
    log(text.toString());
  }
}
