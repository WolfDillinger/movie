import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:movie/favorite/bloc/favorite_bloc.dart';
import 'package:movie/helper/public_val.dart';
import 'package:movie/helper/route.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/movies/bloc/movie_bloc.dart';
import 'package:readmore/readmore.dart';

import '../helper/snack_bar.dart';
import '../style/colors.dart';
import '../style/custom_text.dart';

class MovieInfoPage extends StatefulWidget {
  final MovieModel movie;
  const MovieInfoPage({super.key, required this.movie});

  @override
  State<MovieInfoPage> createState() => _MovieInfoPageState();
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  bool like = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Hero(
        tag: "hero_${widget.movie.id}",
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        image_link + widget.movie.backdrop_path!,
                      ),
                      fit: BoxFit.fill,
                    ),
                    color: white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                router.go("/home");
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: white,
                                size: 30,
                              ),
                            ),

                            CustomText(
                              text: widget.movie.title!,
                              color: white,
                              weight: FontWeight.bold,
                              size: 30,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadowColor: black,
                                color: white,
                                child: Center(
                                  child: LikeButton(
                                    animationDuration: Duration(
                                      milliseconds: 1000,
                                    ),
                                    isLiked: like,
                                    onTap: (val) async {
                                      like = !like;
                                      context.read<FavoriteBloc>().add(
                                        FavMovieEvent(
                                          like: like,
                                          val: widget.movie.id!,
                                        ),
                                      );
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: size.height * 0.77,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Center(
                            child: ReadMoreText(
                              widget.movie.overview!,
                              textAlign: TextAlign.justify,
                              trimCollapsedText: ' See more',
                              trimExpandedText: " Show more",
                              colorClickableText: black,
                              trimLength: 50,
                              trimMode: TrimMode.Length,
                              style: TextStyle(
                                color: words,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Release Date : ",
                                weight: FontWeight.bold,
                                size: 24,
                                color: black,
                              ),
                              CustomText(
                                text: widget.movie.release_date!,
                                weight: FontWeight.normal,
                                size: 20,
                                color: black,
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "popularity : ",
                                weight: FontWeight.bold,
                                size: 24,
                                color: black,
                              ),
                              CustomText(
                                text: widget.movie.popularity!.toStringAsFixed(
                                  1,
                                ),
                                weight: FontWeight.normal,
                                size: 20,
                                color: black,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Vote Average : ",
                                weight: FontWeight.bold,
                                size: 24,
                                color: black,
                              ),
                              CustomText(
                                text: widget.movie.vote_average!
                                    .toStringAsFixed(1),
                                weight: FontWeight.normal,
                                size: 20,
                                color: black,
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                initialRating: widget.movie.vote_average! / 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                itemBuilder:
                                    (context, _) =>
                                        Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {
                                  context.read<MovieBloc>().add(
                                    RateMovieEvent(
                                      id: widget.movie.id!,
                                      val: rating,
                                    ),
                                  );
                                  showSnack(context, "User Rating");
                                },
                              ),
                              SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<MovieBloc>().add(
                                    DeleteMovieEvent(val: widget.movie.id!),
                                  );

                                  showSnack(context, "Rating Deleted");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: red,
                                  elevation: 10,
                                  shadowColor: black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  width: size.width * 0.5,
                                  child: Center(
                                    child: CustomText(
                                      text: "Delete Rating",
                                      color: white,
                                      weight: FontWeight.bold,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
