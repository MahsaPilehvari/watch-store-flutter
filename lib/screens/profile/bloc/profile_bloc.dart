import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watch_store/data/model/order.dart';
import 'package:watch_store/data/model/profile.dart';
import 'package:watch_store/data/repository/profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   final IProfileRepo _iProfileRepo;

//   ProfileBloc(this._iProfileRepo) : super(ProfileLoading()) {
//     on<ProfileEvent>((event, emit) async {
//       if (event is ProfileInit) {
//         try {
//           emit(ProfileLoading());
//           final response = await _iProfileRepo.getUserProfile();
//           emit(ProfileSuccess(response));
//         } catch (e) {
//           // emit(ProfileError("خطا در دریافت اطلاعات حساب کاربری"));
//           emit(ProfileError(e.toString()));
//         }
//       }
//       if (event is UserProcessingOrders) {
//         try {
//           emit(UserProcessingOrderLoading());
//           final response = await _iProfileRepo.getUserProcessingOrders();
//           emit(UserProcessingOrderSuccess(response));
//         } catch (e) {
//           emit(UserProcessingOrderError(e.toString()));
//           // emit(UserOrderError('error'));
//         }
//       }
//       if (event is UserCancelledOrdersEvent) {
//         try {
//           emit(UserCancelledOrderLoading());
//           final response = await _iProfileRepo.getUserCancelledOrders();
//           emit(UserCancelledOrderSuccess(response));
//         } catch (e) {
//           emit(UserCancelledOrderError(e.toString()));
//           // emit(UserOrderError('error'));
//         }
//       }
//       if (event is UserReceivedOrders) {
//         try {
//           emit(UserReceivedOrderLoading());
//           final response = await _iProfileRepo.getUserReceivedOrders();
//           emit(UserReceivedOrderSuccess(response));
//         } catch (e) {
//           emit(UserReceivedOrderError(e.toString()));
//           // emit(UserOrderError('error'));
//         }
//       }
//     });
//   }
// }

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
              // selectedAddress: addressList.isNotEmpty ? addressList.first : "",
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
