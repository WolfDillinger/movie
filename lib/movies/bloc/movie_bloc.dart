import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../model/movie.dart';
import '../../service/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieServices _services = MovieServices();
  MovieBloc() : super(MovieState()) {
    on<MovieEvent>((event, emit) async {
      if (event is GetMovieEvent) {
        if (state.hasReachedMax) return;
        try {
          if (state.status == MovieStatus.loading) {
            final movies = await _services.get();
            return movies.isEmpty
                ? emit(
                  state.copyWith(
                    status: MovieStatus.success,
                    hasReachedMax: true,
                  ),
                )
                : emit(
                  state.copyWith(
                    status: MovieStatus.success,
                    movies: movies,
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
                    status: MovieStatus.success,
                    movies: List.of(state.movies)..addAll(movies),
                    hasReachedMax: false,
                    page: state.page + 1,
                  ),
                );
          }
        } catch (e) {
          emit(
            state.copyWith(
              status: MovieStatus.error,
              errorMessage: "failed to fetch movies",
            ),
          );
        }
      } else if (event is GetSearchMovieEvent) {
        try {
          emit(state.copyWith(status: MovieStatus.loading));
          final searchResults = await _services.search(event.val);
          return searchResults.isEmpty
              ? emit(
                state.copyWith(
                  status: MovieStatus.success,
                  movies: [],
                  hasReachedMax: true,
                ),
              )
              : emit(
                state.copyWith(
                  status: MovieStatus.success,
                  movies: searchResults,
                  hasReachedMax: false,
                  page: 1,
                ),
              );
        } catch (e) {
          emit(
            state.copyWith(
              status: MovieStatus.error,
              errorMessage: "Failed to fetch search results",
            ),
          );
        }
      } else if (event is RateMovieEvent) {
        try {
          await _services.addRate(event.id, event.val);
          final movies = await _services.get();

          return movies.isEmpty
              ? emit(
                state.copyWith(
                  status: MovieStatus.success,
                  movies: [],
                  hasReachedMax: true,
                ),
              )
              : emit(
                state.copyWith(
                  status: MovieStatus.success,
                  movies: movies,
                  hasReachedMax: false,
                  page: 1,
                ),
              );
        } catch (e) {
          emit(
            state.copyWith(
              status: MovieStatus.error,
              errorMessage: "Failed to fetch search results",
            ),
          );
        }
      } else if (event is DeleteMovieEvent) {
        try {
          await _services.deleteRate(event.val);
          final movies = await _services.get();

          return movies.isEmpty
              ? emit(
                state.copyWith(
                  status: MovieStatus.success,
                  movies: [],
                  hasReachedMax: true,
                ),
              )
              : emit(
                state.copyWith(
                  status: MovieStatus.success,
                  movies: movies,
                  hasReachedMax: false,
                  page: 1,
                ),
              );
        } catch (e) {
          emit(
            state.copyWith(
              status: MovieStatus.error,
              errorMessage: "Failed to fetch search results",
            ),
          );
        }
      }
    }, transformer: droppable());
  }
}
