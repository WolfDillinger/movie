part of 'top_bloc.dart';

sealed class TopEvent extends Equatable {
  const TopEvent();

  @override
  List<Object> get props => [];
}

class GetTopMovieEvent extends TopEvent {}
