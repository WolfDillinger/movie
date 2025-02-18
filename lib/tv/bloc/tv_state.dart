part of 'tv_bloc.dart';

enum TvStatus { loading, success, error }

class TvState extends Equatable {
  final TvStatus status;
  final List<TvModel> tvs;
  final bool hasReachedMax;
  final int page;
  final String errorMessage;

  const TvState({
    this.status = TvStatus.loading,
    this.hasReachedMax = false,
    this.tvs = const [],
    this.errorMessage = "",
    this.page = 1,
  });

  TvState copyWith({
    TvStatus? status,
    List<TvModel>? tvs,
    bool? hasReachedMax,
    String? errorMessage,
    int? page,
  }) {
    return TvState(
      status: status ?? this.status,
      tvs: tvs ?? this.tvs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [status, tvs, hasReachedMax, errorMessage, page];
}
