part of 'profile_bloc.dart';

// sealed class ProfileState {}

// final class ProfileLoading extends ProfileState {}

// final class ProfileError extends ProfileState {
//   final String error;

//   ProfileError(this.error);
// }

// final class ProfileSuccess extends ProfileState {
//   final ProfileInfo profileModel;

//   ProfileSuccess(this.profileModel);
// }

// /////////////////////////////////////////////////////////

// final class ProfileAddressLoading extends ProfileState {}

// final class ProfileAddressError extends ProfileState {
//   final String error;

//   ProfileAddressError(this.error);
// }

// /////////////////////////////////////////////////////////

// final class UserProcessingOrderLoading extends ProfileState {}

// final class UserProcessingOrderError extends ProfileState {
//   final String error;

//   UserProcessingOrderError(this.error);
// }

// final class UserProcessingOrderSuccess extends ProfileState {
//   final List<Order> orderList;

//   UserProcessingOrderSuccess(this.orderList);
// }

// /////////////////////////////////////////////////////////

// final class UserCancelledOrderLoading extends ProfileState {}

// final class UserCancelledOrderError extends ProfileState {
//   final String error;

//   UserCancelledOrderError(this.error);
// }

// final class UserCancelledOrderSuccess extends ProfileState {
//   final List<Order> orderList;

//   UserCancelledOrderSuccess(this.orderList);
// }

// /////////////////////////////////////////////////////////

// final class UserReceivedOrderLoading extends ProfileState {}

// final class UserReceivedOrderError extends ProfileState {
//   final String error;

//   UserReceivedOrderError(this.error);
// }

// final class UserReceivedOrderSuccess extends ProfileState {
//   final List<Order> orderList;

//   UserReceivedOrderSuccess(this.orderList);
// }

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
