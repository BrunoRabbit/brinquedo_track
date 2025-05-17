// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:brinquedo_track/models/login_model.dart';

class SessionModel {
  final String token;
  final String sessionId;
  final LoginModel login;

  const SessionModel({
    required this.token,
    required this.sessionId,
    required this.login,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'sessionId': sessionId,
      'login': login.toMap(),
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      token: map['token'] as String,
      sessionId: map['sessionId'] as String,
      login: LoginModel.fromMap(map['login'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
