part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ActivityEntity> activites;
  const HomeLoaded({required this.activites});

  @override
  List<Object> get props => [activites];
}

class ErrorHomeState extends HomeState {
  final String message;

  const ErrorHomeState({required this.message});

  @override
  List<Object> get props => [message];
}
