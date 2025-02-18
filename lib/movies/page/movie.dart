import 'package:flutter/material.dart';
import 'package:movie/helper/public_val.dart';
import 'package:movie/helper/route.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/style/custom_text.dart';
import '../../style/colors.dart';

class MovieWidget extends StatelessWidget {
  final MovieModel movie;
  final bool full;
  const MovieWidget({super.key, required this.movie, required this.full});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        router.go("/movie", extra: movie);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Hero(
          tag: "hero_${movie.id}",
          child: Card(
            elevation: 10,
            shadowColor: black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Image.network(
                    image_link + movie.poster_path!,
                    fit: BoxFit.fill,
                    width: full ? size.width * 0.9 : size.width * 0.5,
                    height: size.height * 0.2,
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: movie.title!,
                    weight: FontWeight.w900,
                    size: 22,
                    cut: true,
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: size.width * 0.49,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Rating :",
                              weight: FontWeight.w900,
                              size: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: (movie.vote_average! / 2)
                                      .toStringAsFixed(1),
                                  weight: FontWeight.bold,
                                  size: 18,
                                ),
                                Icon(Icons.star, color: Colors.amber, size: 28),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Release Date :",
                              weight: FontWeight.w900,
                              size: 18,
                            ),
                            CustomText(
                              text: movie.release_date!,
                              weight: FontWeight.bold,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
