part of 'top_bloc.dart';

enum TopStatus { loading, success, error }

class TopState extends Equatable {
  final TopStatus status;
  final List<MovieModel> movies;
  final bool hasReachedMax;
  final int page;
  final String errorMessage;

  const TopState({
    this.status = TopStatus.loading,
    this.hasReachedMax = false,
    this.movies = const [],
    this.errorMessage = "",
    this.page = 1,
  });

  TopState copyWith({
    TopStatus? status,
    List<MovieModel>? movies,
    bool? hasReachedMax,
    String? errorMessage,
    int? page,
  }) {
    return TopState(
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
