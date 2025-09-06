import 'package:dio/dio.dart';
import 'package:watch_store/data/model/home.dart';
import 'package:watch_store/data/src/home_data_src.dart';

abstract class IHomeRepository {
  Future<Home> getHome();
}

class HomeRepository implements IHomeRepository {
  final IHomeDataSrc _iHomeDataSrc;

  HomeRepository(this._iHomeDataSrc);

  @override
  Future<Home> getHome() => _iHomeDataSrc.getHome();
}

final homeRepository = HomeRepository(HomeRemoteDataSrc(Dio()));
