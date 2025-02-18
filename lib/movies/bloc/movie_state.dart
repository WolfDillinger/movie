part of 'movie_bloc.dart';

enum MovieStatus { loading, success, error }

class MovieState extends Equatable {
  final MovieStatus status;
  final List<MovieModel> movies;
  final bool hasReachedMax;
  final int page;
  final String errorMessage;

  const MovieState({
    this.status = MovieStatus.loading,
    this.hasReachedMax = false,
    this.movies = const [],
    this.errorMessage = "",
    this.page = 1,
  });

  MovieState copyWith({
    MovieStatus? status,
    List<MovieModel>? movies,
    bool? hasReachedMax,
    String? errorMessage,
    int? page,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
    status,
    movies,
    hasReachedMax,
    errorMessage,
    page,
  ];
}
