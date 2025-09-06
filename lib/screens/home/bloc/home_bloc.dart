import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/data/model/home.dart';
import 'package:watch_store/data/repository/home_repo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepository iHomeRepository;
  HomeBloc(this.iHomeRepository) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeInit) {
        try {
          emit(HomeLoading());
          final home = await iHomeRepository.getHome();
          emit(HomeLoaded(home));
        } catch (e) {
          emit(HomeError(message: "HomeBloc Error: $e"));
        }
      }
    });
  }
}
