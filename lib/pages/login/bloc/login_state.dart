part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class AppInitial extends LoginState {}

final class AppLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailure extends LoginState {}
