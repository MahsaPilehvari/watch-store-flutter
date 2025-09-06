part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
  @override
  List<Object> get props => [message];
}

final class HomeLoaded extends HomeState {
  final Home home;
  const HomeLoaded(this.home);
  @override
  List<Object> get props => [home];
}
