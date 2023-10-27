import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moodflix/core/enum/movie_list_type.dart';
import 'package:moodflix/features/collection/widgets/rating_chip.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MovieRowWidget extends StatelessWidget {
  final Movie movie;
  final MovieListType movieListType;

  const MovieRowWidget(
      {super.key, required this.movie, required this.movieListType});

  @override
  Widget build(BuildContext context) {
    double leadingImageHeight = 130.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              width: leadingImageHeight * 2 / 3,
              height: leadingImageHeight,
              imageUrl: movie.posterPath,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 90),
              fadeOutDuration: const Duration(milliseconds: 30),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(fontSize: 19),
                  overflow: TextOverflow.ellipsis, // Add ellipsis for long text
                  maxLines: 2, // Limit to one line
                ),
                Text(
                  movie.releaseYear.toString(),
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (movieListType == MovieListType.wishedMovies)
            const Icon(
              Icons.bookmark_added_rounded,
              color: Colors.blueGrey,
            ),
          if (movieListType == MovieListType.ratedMovies)
            RatingChip(movie: movie),
        ],
      ),
    );
  }
}
