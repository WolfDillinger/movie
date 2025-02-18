import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/model/tv.dart';
import 'package:movie/service/tv.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final TvServices _services = TvServices();
  TvBloc() : super(TvState()) {
    on<TvEvent>((event, emit) async {
      if (event is GetTvEvent) {
        if (state.hasReachedMax) return;
        try {
          if (state.status == TvStatus.loading) {
            final tvs = await _services.get();
            return tvs.isEmpty
                ? emit(
                  state.copyWith(status: TvStatus.success, hasReachedMax: true),
                )
                : emit(
                  state.copyWith(
                    status: TvStatus.success,
                    tvs: tvs,
                    hasReachedMax: false,
                    page: state.page + 1,
                  ),
                );
          } else {
            final movies = await _services.get(state.page);
            movies.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(
                  state.copyWith(
                    status: TvStatus.success,
                    tvs: List.of(state.tvs)..addAll(movies),
                    hasReachedMax: false,
                    page: state.page + 1,
                  ),
                );
          }
        } catch (e) {
          emit(
            state.copyWith(
              status: TvStatus.error,
              errorMessage: "failed to fetch movies",
            ),
          );
        }
      } else {
        print("didnt work");
      }
    }, transformer: droppable());
  }
}
