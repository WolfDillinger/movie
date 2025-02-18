import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/movies/bloc/movie_bloc.dart';
import 'package:movie/style/appbar.dart';

import '../movies/page/movie.dart';
import '../style/colors.dart';
import '../widget/loading.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        title: "Search",
        lead: IconButton(
          onPressed: () {
            context.go("/home");
          },
          icon: Icon(Icons.keyboard_arrow_left_rounded, color: white, size: 30),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        icon: Icon(Icons.search, size: 32),
                      ),
                      onFieldSubmitted: (value) {
                        context.read<MovieBloc>().add(
                          GetSearchMovieEvent(val: value),
                        );
                      },
                    ),
                  ),
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
                        height: size.height * 0.8,
                        width: size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,

                          itemCount: state.movies.length,
                          itemBuilder: (context, index) {
                            return MovieWidget(
                              movie: state.movies[index],
                              full: true,
                            );
                          },
                        ),
                      );

                    case MovieStatus.error:
                      return Center(child: Text(state.errorMessage));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
