import 'package:go_router/go_router.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/screen/movie_info.dart';
import 'package:movie/screen/tv_info.dart';
import '../model/tv.dart';
import '../screen/loading.dart';
import '../screen/home.dart';
import '../screen/search.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoadingPage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/search', builder: (context, state) => SearchPage()),
    GoRoute(
      path: "/movie",
      builder: (context, state) {
        final movie = state.extra as MovieModel;
        return MovieInfoPage(movie: movie);
      },
    ),
    GoRoute(
      path: "/tv",
      builder: (context, state) {
        final tv = state.extra as TvModel;
        return TvInfoPage(tv: tv);
      },
    ),
  ],
);
