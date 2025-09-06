part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileErrorState extends ProfileState {
  final String message;

  const ProfileErrorState(this.message);
  @override
  List<Object> get props => [message];
}

final class ProfileLoadingState extends ProfileState {}

final class ProfileLoadedState extends ProfileState {
  final Profile profile;

  const ProfileLoadedState({required this.profile});
  @override
  List<Object> get props => [profile];
}

final class ProfileAddressLoadingState extends ProfileState {}

final class ProfileAddressLoaded extends ProfileState {
  final List<String> addressList;
  final String? selectedAddress;
  const ProfileAddressLoaded({required this.addressList, this.selectedAddress});
  @override
  List<Object> get props => [addressList];
}

final class ProfileReceivedOrdersLoaded extends ProfileState {
  final List<Order> orderList;

  const ProfileReceivedOrdersLoaded({required this.orderList});
  @override
  List<Object> get props => [orderList];
}

final class ProfileCanceledOrdersLoaded extends ProfileState {
  final List<Order> orderList;

  const ProfileCanceledOrdersLoaded({required this.orderList});
  @override
  List<Object> get props => [orderList];
}

final class ProfileprocessingOrdersLoaded extends ProfileState {
  final List<Order> orderList;

  const ProfileprocessingOrdersLoaded({required this.orderList});
  @override
  List<Object> get props => [orderList];
}
