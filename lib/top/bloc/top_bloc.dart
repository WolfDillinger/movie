import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/model/movie.dart';

import '../../service/movie.dart';

part 'top_event.dart';
part 'top_state.dart';

class TopBloc extends Bloc<TopEvent, TopState> {
  final MovieServices _services = MovieServices();

  TopBloc() : super(TopState()) {
    on<TopEvent>((event, emit) async {
      if (event is GetTopMovieEvent) {
        try {
          if (state.status == TopStatus.loading) {
            emit(state.copyWith(movies: []));
            final top = await _services.top();
            return top.isEmpty
                ? emit(
                  state.copyWith(
                    status: TopStatus.success,
                    hasReachedMax: true,
                  ),
                )
                : emit(
                  state.copyWith(
                    status: TopStatus.success,
                    movies: top,
                    hasReachedMax: false,
                    page: state.page + 1,
                  ),
                );
          } else {
            final top = await _services.top(state.page);
            top.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(
                  state.copyWith(
                    status: TopStatus.success,
                    movies: List.of(state.movies)..addAll(top),
                    hasReachedMax: false,
                    page: state.page + 1,
                  ),
                );
          }
        } catch (e) {
          emit(
            state.copyWith(
              status: TopStatus.error,
              errorMessage: "failed to fetch movies",
            ),
          );
        }
      }
    }, transformer: droppable());
  }
}
