import 'dart:collection';
import 'dart:convert';

import 'package:brinquedo_track/services/monitoring_service.dart';
import 'package:brinquedo_track/storage/secure_storage_interface.dart';
import 'package:http/http.dart' as http;

enum AuthType {
  bearer,
  login,
  none,
}

abstract class BaseHttpRequest {
  Future<String> get({
    required String endpoint,
    Map<String, String>? headers,
    AuthType authType = AuthType.bearer,
  });

  Future<String> post({
    required String endpoint,
    required Object body,
    Map<String, String>? headers,
    AuthType authType = AuthType.bearer,
  });

  Future<String> delete({
    required String endpoint,
    required Object body,
    Map<String, String>? headers,
    AuthType authType = AuthType.bearer,
  });

  Future<String> put({
    required String endpoint,
    required Object body,
    Map<String, String>? headers,
    AuthType authType = AuthType.bearer,
  });
}

class HttpRequest implements BaseHttpRequest {
  final SecureStorageInterface secureStorage;
  final BaseMonitoringService monitoringService;
  late final HashMap<String, String> headers;

  HttpRequest({
    required this.secureStorage,
    required this.monitoringService,
  }) {
    headers = HashMap();
  }

  static const String bearerKey = 'bearer';

  static Uri buildUri(String endpoint) {
    const String url = String.fromEnvironment('API_URL');

    return Uri.parse('$url$endpoint');
  }

  @override
  Future<String> delete({
    required String endpoint,
    required Object body,
    AuthType authType = AuthType.bearer,
    Map<String, String>? headers,
  }) async {
    return _parseResponse(
      await _doRequest(
        'DELETE',
        endpoint: endpoint,
        authType: authType,
        body: body,
      ),
    );
  }

  @override
  Future<String> get({
    required String endpoint,
    AuthType authType = AuthType.bearer,
    Map<String, String>? headers,
  }) async {
    return _parseResponse(
      await _doRequest(
        'GET',
        endpoint: endpoint,
        authType: authType,
      ),
    );
  }

  @override
  Future<String> put({
    required String endpoint,
    required Object body,
    Map<String, String>? headers,
    AuthType authType = AuthType.bearer,
  }) async {
    return _parseResponse(
      await _doRequest(
        'PUT',
        body: body,
        endpoint: endpoint,
        authType: authType,
      ),
    );
  }

  @override
  Future<String> post({
    required String endpoint,
    required Object body,
    AuthType authType = AuthType.bearer,
    Map<String, String>? headers,
  }) async {
    return _parseResponse(
      await _doRequest(
        'POST',
        body: body,
        endpoint: endpoint,
        authType: authType,
      ),
    );
  }

  String _parseResponse(http.Response response) {
    var url = response.request!.url;
    var method = response.request!.method;
    var respondeBody = response.body;

    monitoringService.logger(
      'Response: $method - URL: $url  ${response.statusCode} data: $respondeBody',
    );

    if ([200, 201, 204].contains(response.statusCode)) {
      if (respondeBody != "null" && respondeBody.isNotEmpty) {
        return respondeBody;
      } else {
        return "";
      }
    } else {
      return getHttpException(response);
    }
  }

  Future<http.Response> _doRequest(
    String method, {
    required String endpoint,
    required AuthType authType,
    Object? body,
  }) async {
    await _applyHeaders(authType);
    final uri = buildUri(endpoint);

    monitoringService.logger(
      'Request: $method - URL: $uri headers: $headers body: $body',
    );

    final result = switch (method) {
      'GET' => await http.get(uri, headers: headers),
      'POST' => await http.post(uri, body: jsonEncode(body), headers: headers),
      'PUT' => await http.put(uri, body: jsonEncode(body), headers: headers),
      'PATCH' =>
        await http.patch(uri, body: jsonEncode(body), headers: headers),
      'DELETE' =>
        await http.delete(uri, body: jsonEncode(body), headers: headers),
      _ => throw UnimplementedError(),
    };

    return result;
  }

  Future<void> _applyHeaders(AuthType authType) async {
    headers.addAll({
      'Content-Type': 'application/json',
    });

    final bearer = await secureStorage.getString(bearerKey);

    if (authType == AuthType.bearer) {
      headers.addAll({
        'Authorization': 'Bearer $bearer',
      });
    }
  }

  getHttpException(Object error) {
    return error.toString();
    // scaffoldKey.currentState!.showSnackBar(
    //   SnackBar(
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: Colors.red,
    //     content: Text(
    //       _getErrorMessage(errorType),
    //       style: const TextStyle(color: Colors.white),
    //     ),
    //   ),
    // );
  }
}
