import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/data/model/order.dart';
import 'package:watch_store/data/model/profile.dart';
import 'package:watch_store/data/repository/profile_repo.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileRepository _iProfileRepository;
  ProfileBloc(this._iProfileRepository) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileInitEvent) {
        try {
          emit(ProfileLoadingState());
          final profile = await _iProfileRepository.getProfileInfo();

          emit(ProfileLoadedState(profile: profile));
        } catch (e) {
          emit(ProfileErrorState("$e خطا در بارگذاری اطلاعات کاربری"));
        }
      }
      if (event is ProfileAddressEvent) {
        try {
          emit(ProfileAddressLoadingState());
          final userAddresses = await _iProfileRepository.getUserAddresses();
          final List<String> addressList =
              userAddresses.map((e) => e.address.toString()).toList();

          emit(
            ProfileAddressLoaded(
              addressList: addressList,
              selectedAddress: " ",
            ),
          );
        } catch (e) {
          emit(ProfileErrorState("$e خطا در بارگذاری آدرس"));
        }
      }
      if (event is SelectAddress) {
        try {
          emit(ProfileAddressLoadingState());
          final userAddresses = await _iProfileRepository.getUserAddresses();
          final List<String> addressList =
              userAddresses.map((e) => e.address.toString()).toList();

          emit(
            ProfileAddressLoaded(
              addressList: addressList,
              selectedAddress: event.selectedAddress,
            ),
          );
        } catch (e) {
          emit(ProfileErrorState("$e خطا در بارگذاری آدرس"));
        }
      }
      if (event is ProfileCancelledOrdersEvent) {
        try {
          emit(ProfileLoadingState());
          final orderList = await _iProfileRepository.getCanceledOrders();

          emit(ProfileCanceledOrdersLoaded(orderList: orderList));
        } catch (e) {
          emit(ProfileErrorState("$e خطا در بارگذاری لیست سفارشات کنسل شده"));
        }
      }
      if (event is ProfileReceivedOrdersEvent) {
        try {
          emit(ProfileLoadingState());
          final orderList = await _iProfileRepository.getRecievedOrders();

          emit(ProfileReceivedOrdersLoaded(orderList: orderList));
        } catch (e) {
          emit(ProfileErrorState("$e خطا در بارگذاری لیست سفارشات دریافت شده"));
        }
      }
      if (event is ProfileProcessingOrdersEvent) {
        try {
          emit(ProfileLoadingState());
          final orderList = await _iProfileRepository.getProcessingOrders();

          emit(ProfileprocessingOrdersLoaded(orderList: orderList));
        } catch (e) {
          emit(
            ProfileErrorState("$e خطا در بارگذاری لیست سفارشات در حال ارسال"),
          );
        }
      }
    });
  }
}
