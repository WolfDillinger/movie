part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetMovieFavoritesEvent extends FavoriteEvent {}

class FavMovieEvent extends FavoriteEvent {
  final int val;
  final bool like;

  const FavMovieEvent({required this.val, required this.like});

  @override
  List<Object> get props => [val];
}
