part of 'root_bloc.dart';

@immutable
sealed class RootState {}

final class AppInitial extends RootState {}

final class AppLoading extends RootState {}

final class Authenticated extends RootState {}

final class Unauthenticated extends RootState {}
