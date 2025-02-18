import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/top/bloc/top_bloc.dart';

import '../../movies/page/movie.dart';
import '../../widget/loading.dart';

class TopRateWidget extends StatefulWidget {
  const TopRateWidget({super.key});

  @override
  State<TopRateWidget> createState() => _TopRateWidgetState();
}

class _TopRateWidgetState extends State<TopRateWidget> {
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
      context.read<TopBloc>().add(GetTopMovieEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TopBloc, TopState>(
      builder: (context, state) {
        switch (state.status) {
          case TopStatus.loading:
            return const LoadingWidget();
          case TopStatus.success:
            if (state.movies.isEmpty) {
              return const Center(child: Text("Empty"));
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

          case TopStatus.error:
            return Center(child: Text(state.errorMessage));
        }
      },
    );
  }
}
