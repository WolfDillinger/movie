part of 'favorite_bloc.dart';

enum FavoriteStatus { loading, success, error }

class FavoriteState extends Equatable {
  final FavoriteStatus status;
  final List<MovieModel> movies;
  final bool hasReachedMax;
  final int page;
  final String errorMessage;

  const FavoriteState({
    this.status = FavoriteStatus.loading,
    this.hasReachedMax = false,
    this.movies = const [],
    this.errorMessage = "",
    this.page = 1,
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<MovieModel>? movies,
    bool? hasReachedMax,
    String? errorMessage,
    int? page,
  }) {
    return FavoriteState(
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
