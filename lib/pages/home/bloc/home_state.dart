part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class AppInitial extends HomeState {}

final class AppLoading extends HomeState {}

final class FetchedSuccess extends HomeState {
  final List<CustomerListModel>? customers;

  const FetchedSuccess({
    required this.customers,
  });
}

final class FetchedFailed extends HomeState {
  final String error;

  const FetchedFailed({
    required this.error,
  });
}
