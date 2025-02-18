import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/favorite/bloc/favorite_bloc.dart';
import 'package:movie/movies/bloc/movie_bloc.dart';
import 'package:movie/top/bloc/top_bloc.dart';
import 'package:movie/tv/bloc/tv_bloc.dart';
import 'helper/route.dart';
import 'style/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieBloc()..add(GetMovieEvent()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => TvBloc()..add(GetTvEvent()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FavoriteBloc()..add(GetMovieFavoritesEvent()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => TopBloc()..add(GetTopMovieEvent()),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        title: 'Movies',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: white)),
        ),
        themeAnimationDuration: Duration(seconds: 3),
        debugShowCheckedModeBanner: false,
        themeAnimationCurve: Curves.linear,
        routerConfig: router, // Use GoRouter here
      ),
    );
  }
}
