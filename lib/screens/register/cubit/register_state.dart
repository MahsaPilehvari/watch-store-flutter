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
