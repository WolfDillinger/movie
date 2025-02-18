import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/favorite/bloc/favorite_bloc.dart';
import 'package:movie/screen/discover.dart';
import 'package:movie/style/colors.dart';
import 'package:movie/style/custom_text.dart';
import 'package:movie/top/bloc/top_bloc.dart';
import '../style/appbar.dart';
import '../favorite/page/favorites.dart';
import '../top/page/top_rate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "Home";

  int index = 0;

  List<Widget> screens = [DiscoverPage(), FavoritesWidget(), TopRateWidget()];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppBarWidget(
                  title: title,
                  shape: 10,

                  widget: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.go("/search");
                          },
                          child: Icon(Icons.search, color: white, size: 35),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.75,
                child: SingleChildScrollView(child: screens.elementAt(index)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 7,
        color: c_1,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      index = 0;
                      title = "Home";
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.home, color: index == 0 ? white : black),
                      CustomText(
                        text: 'Discover',
                        color: index == 0 ? white : black,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    context.read<FavoriteBloc>().add(GetMovieFavoritesEvent());
                    setState(() {
                      index = 1;
                      title = 'Favorites';
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, color: index == 1 ? white : black),
                      CustomText(
                        text: 'Favorites',
                        color: index == 1 ? white : black,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    context.read<TopBloc>().add(GetTopMovieEvent());

                    setState(() {
                      index = 2;
                      title = 'Top-Rated';
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, color: index == 2 ? white : black),
                      CustomText(
                        text: 'Top-Rated',
                        color: index == 2 ? white : black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
