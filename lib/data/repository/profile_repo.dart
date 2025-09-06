import 'package:watch_store/data/model/order.dart';
import 'package:watch_store/data/model/profile.dart';
import 'package:watch_store/data/src/profile_data_src.dart';

abstract class IProfileRepository {
  Future<Profile> getProfileInfo();
  Future<List> getUserAddresses();
  Future<List<Order>> getRecievedOrders();
  Future<List<Order>> getProcessingOrders();
  Future<List<Order>> getCanceledOrders();
}

class ProfileRepository implements IProfileRepository {
  final IProfileDataSrc _iProfileDataSrc;

  ProfileRepository(this._iProfileDataSrc);
  @override
  Future<List<Order>> getCanceledOrders() =>
      _iProfileDataSrc.getCanceledOrders();

  @override
  Future<List<Order>> getProcessingOrders() =>
      _iProfileDataSrc.getProcessingOrders();

  @override
  Future<Profile> getProfileInfo() => _iProfileDataSrc.getProfileInfo();

  @override
  Future<List<Order>> getRecievedOrders() =>
      _iProfileDataSrc.getRecievedOrders();

  @override
  Future<List> getUserAddresses() => _iProfileDataSrc.getUserAddresses();
}
