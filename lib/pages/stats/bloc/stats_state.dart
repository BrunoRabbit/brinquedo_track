part of 'stats_bloc.dart';

@immutable
sealed class StatsState {
  const StatsState();
}

final class StatsInitial extends StatsState {}

final class StatsLoading extends StatsState {}

final class StatsLoaded extends StatsState {
  final List<HighlightModel> highlights;
  final List<DailySaleModel> dailySales;

  const StatsLoaded({
    required this.highlights,
    required this.dailySales,
  });
}

final class FetchedFailed extends StatsState {
  final String error;

  const FetchedFailed({
    required this.error,
  });
}
