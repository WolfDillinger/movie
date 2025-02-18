import 'package:flutter/material.dart';

import '../model/slider.dart';
import '../movies/page/movie.dart';
import '../style/colors.dart';
import '../style/custom_text.dart';
import '../tv/page/tv.dart';
import '../widget/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movies/bloc/movie_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie/tv/bloc/tv_bloc.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final _scrollController = ScrollController();
  final _scrollController1 = ScrollController();

  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  List<SliderModel> sliders = [
    SliderModel(img: "assets/images/logo.png", id: "4"),
    SliderModel(img: "assets/images/logo.png", id: "2"),
    SliderModel(img: "assets/images/logo.png", id: "3"),
    SliderModel(img: "assets/images/logo.png", id: "1"),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _scrollController1.addListener(_onScroll1);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _scrollController1
      ..removeListener(_onScroll1)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<MovieBloc>().add(GetMovieEvent());
    }
  }

  void _onScroll1() {
    final maxScroll = _scrollController1.position.maxScrollExtent;
    final currentScroll = _scrollController1.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<TvBloc>().add(GetTvEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: 10),
        CarouselSlider(
          items:
              sliders.map((i) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Card(
                    elevation: 10,
                    color: white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(i.img!, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                );
              }).toList(),
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 2.0,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Movies", weight: FontWeight.bold, size: 24),
              CustomText(text: "All", weight: FontWeight.bold, size: 24),
            ],
          ),
        ),

        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            switch (state.status) {
              case MovieStatus.loading:
                return const LoadingWidget();
              case MovieStatus.success:
                if (state.movies.isEmpty) {
                  return const Center(child: Text("No Movies"));
                }

                return Container(
                  height: size.height * 0.42,
                  width: size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,

                    itemCount:
                        state.hasReachedMax
                            ? state.movies.length
                            : state.movies.length + 1,
                    itemBuilder: (context, index) {
                      return index >= state.movies.length
                          ? const LoadingWidget()
                          : MovieWidget(
                            movie: state.movies[index],
                            full: false,
                          );
                    },
                  ),
                );

              case MovieStatus.error:
                return Center(child: Text(state.errorMessage));
            }
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Tvs", weight: FontWeight.bold, size: 24),
              CustomText(text: "All", weight: FontWeight.bold, size: 24),
            ],
          ),
        ),

        BlocBuilder<TvBloc, TvState>(
          builder: (context, state) {
            switch (state.status) {
              case TvStatus.loading:
                return const LoadingWidget();
              case TvStatus.success:
                if (state.tvs.isEmpty) {
                  return const Center(child: Text("No Tv Show"));
                }

                return Container(
                  height: size.height * 0.42,
                  width: size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController1,

                    itemCount:
                        state.hasReachedMax
                            ? state.tvs.length
                            : state.tvs.length + 1,
                    itemBuilder: (context, index) {
                      return index >= state.tvs.length
                          ? const LoadingWidget()
                          : TvWidget(tv: state.tvs[index]);
                    },
                  ),
                );

              case TvStatus.error:
                return Center(child: Text(state.errorMessage));
            }
          },
        ),

        SizedBox(height: 15),
      ],
    );
  }
}
