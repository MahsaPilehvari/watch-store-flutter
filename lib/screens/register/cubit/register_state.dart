import 'package:equatable/equatable.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisteredState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterErrorState extends RegisterState {
  final String message;
  const RegisterErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class PickedLocationState extends RegisterState {
  final GeoPoint? location;
  const PickedLocationState({this.location});

  @override
  List<Object?> get props => [location];
}


// @immutable
// sealed class RegisterState {}

// final class RegisterInitial extends RegisterState {}

// final class LoadingState extends RegisterState {}

// final class ErrorState extends RegisterState {
//   final String message;
//   ErrorState({required this.message});
// }

// final class OkResponseState extends RegisterState {}

// final class LocationPickedState extends RegisterState {
//   final GeoPoint? location;
//   LocationPickedState({required this.location});
// }