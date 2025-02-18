import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../model/movie.dart';
import '../../service/movie.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final MovieServices _services = MovieServices();

  FavoriteBloc() : super(FavoriteState()) {
    on<FavoriteEvent>((event, emit) async {
      if (event is GetMovieFavoritesEvent) {
        if (state.hasReachedMax) return;

        try {
          if (state.status == FavoriteStatus.loading) {
            emit(state.copyWith(movies: []));

            final fav = await _services.favorite();
            return fav.isEmpty
                ? emit(
                  state.copyWith(
                    status: FavoriteStatus.success,
                    hasReachedMax: true,
                  ),
                )
                : emit(
                  state.copyWith(
                    status: FavoriteStatus.success,
                    movies: fav,
                    hasReachedMax: false,
                    page: state.page + 1,
                  ),
                );
          } else {
            final fav = await _services.favorite(state.page);
            fav.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(
                  state.copyWith(
                    status: FavoriteStatus.success,
                    movies: List.of(state.movies)..addAll(fav),
                    hasReachedMax: false,
                    page: state.page + 1,
                  ),
                );
          }
        } catch (e) {
          emit(
            state.copyWith(
              status: FavoriteStatus.error,
              errorMessage: "failed to fetch movies",
            ),
          );
        }
      } else if (event is FavMovieEvent) {
        try {
          await _services.addFav(event.val, event.like);

          final fav = await _services.favorite(state.page);
          fav.isEmpty
              ? emit(state.copyWith(hasReachedMax: true))
              : emit(
                state.copyWith(
                  status: FavoriteStatus.success,
                  movies: List.of(state.movies)..addAll(fav),
                  hasReachedMax: false,
                  page: state.page + 1,
                ),
              );
        } catch (e) {
          emit(
            state.copyWith(
              status: FavoriteStatus.error,
              errorMessage: "failed to fetch movies",
            ),
          );
        }
      }
    }, transformer: droppable());
  }
}
