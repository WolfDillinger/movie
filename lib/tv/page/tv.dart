import 'package:flutter/material.dart';
import 'package:movie/model/tv.dart';

import '../../helper/public_val.dart';
import '../../helper/route.dart';
import '../../style/colors.dart';
import '../../style/custom_text.dart';

class TvWidget extends StatelessWidget {
  final TvModel tv;
  const TvWidget({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        router.go("/tv", extra: tv);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Hero(
          tag: "hero_${tv.id}",
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
                    image_link + tv.poster_path!,
                    fit: BoxFit.fill,
                    width: size.width * 0.5,
                    height: size.height * 0.2,
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: tv.name!,
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
                                  text: (tv.vote_average! / 2).toStringAsFixed(
                                    1,
                                  ),
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
                              text: "First Air :",
                              weight: FontWeight.w900,
                              size: 18,
                            ),
                            CustomText(
                              text: tv.first_air_date!,
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
