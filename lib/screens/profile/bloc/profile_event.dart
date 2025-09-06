part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileInitEvent extends ProfileEvent {}

class ProfileAddressEvent extends ProfileEvent {}

class SelectAddress extends ProfileEvent {
  final String selectedAddress;
  const SelectAddress(this.selectedAddress);
  @override
  List<Object> get props => [selectedAddress];
}

class ProfileCancelledOrdersEvent extends ProfileEvent {}

class ProfileReceivedOrdersEvent extends ProfileEvent {}

class ProfileProcessingOrdersEvent extends ProfileEvent {}
