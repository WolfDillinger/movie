part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetMovieEvent extends MovieEvent {}

class GetSearchMovieEvent extends MovieEvent {
  final String val;

  const GetSearchMovieEvent({required this.val});

  @override
  List<Object> get props => [val];
}

class RateMovieEvent extends MovieEvent {
  final int id;
  final double val;

  const RateMovieEvent({required this.val, required this.id});

  @override
  List<Object> get props => [val];
}

class DeleteMovieEvent extends MovieEvent {
  final int val;

  const DeleteMovieEvent({required this.val});

  @override
  List<Object> get props => [val];
}
