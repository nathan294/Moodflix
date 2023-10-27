import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moodflix/features/collection/widgets/rating_chip.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double moviePosterHeight;

  const MovieCard(
      {super.key, required this.movie, required this.moviePosterHeight});

  @override
  Widget build(BuildContext context) {
    // Assuming a 3:2 aspect ratio for the poster
    double moviePosterWidth = moviePosterHeight * (2 / 3);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: moviePosterWidth,
      ),
      child: Column(
        children: [
          // Movie poster widget
          SizedBox(
            height: moviePosterHeight.toDouble(),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  width: moviePosterWidth,
                  height: moviePosterHeight,
                  imageUrl: movie.posterPath,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 90),
                  fadeOutDuration: const Duration(milliseconds: 30),
                ),
              ),
              // Chip containing user's rating
              // Only display Chip if rating is not null
              if (movie.userRating != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: RatingChip(
                    movie: movie,
                    opacity: 0.8,
                  ),
                ),
            ]),
          ),

          // Movie title
          SizedBox(
            height: 38,
            child: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center, // Center align the text
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
