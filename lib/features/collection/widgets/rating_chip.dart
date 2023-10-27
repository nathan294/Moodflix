import 'package:flutter/material.dart';
import 'package:moodflix/core/functions/movie_rating_color.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class RatingChip extends StatelessWidget {
  final Movie movie;
  final double width;
  final double height;
  final double opacity;
  const RatingChip(
      {super.key,
      required this.movie,
      this.width = 35.0,
      this.height = 35.0,
      this.opacity = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Fixed width
      height: height, // Fixed height
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: fillColor(movie.userRating!, opacity),
        border: Border.all(
          color: Colors.black.withOpacity(0.5),
          width: 0.3,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          movie.userRating.toString(),
          style: const TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
