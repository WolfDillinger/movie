import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/favorite/bloc/favorite_bloc.dart';
import 'package:movie/style/custom_text.dart';
import 'package:movie/widget/loading.dart';
import '../../movies/page/movie.dart';

class FavoritesWidget extends StatefulWidget {
  const FavoritesWidget({super.key});

  @override
  State<FavoritesWidget> createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<FavoriteBloc>().add(GetMovieFavoritesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        switch (state.status) {
          case FavoriteStatus.loading:
            return const LoadingWidget();
          case FavoriteStatus.success:
            if (state.movies.isEmpty) {
              return Container(
                child: Center(
                  child: CustomText(
                    text: "Empty Favorite",
                    weight: FontWeight.bold,
                    size: 24,
                  ),
                ),
              );
            }

            return Container(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                controller: _scrollController,

                itemCount:
                    state.hasReachedMax
                        ? state.movies.length
                        : state.movies.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.movies.length
                      ? const LoadingWidget()
                      : MovieWidget(movie: state.movies[index], full: true);
                },
              ),
            );

          case FavoriteStatus.error:
            return Center(child: Text(state.errorMessage));
        }
      },
    );
  }
}
