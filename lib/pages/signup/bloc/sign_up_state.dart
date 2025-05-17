part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class AppInitial extends SignUpState {}

final class AppLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpFailure extends SignUpState {}
