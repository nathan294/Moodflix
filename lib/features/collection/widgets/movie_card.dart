import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final int moviePosterHeight;

  const MovieCard(
      {super.key, required this.movie, required this.moviePosterHeight});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: moviePosterHeight.toDouble() *
            (2 / 3), // Assuming a 3:2 aspect ratio for the poster
      ),
      child: Column(
        children: [
          SizedBox(
            height: moviePosterHeight.toDouble(),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: movie.posterPath,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 90),
                  fadeOutDuration: const Duration(milliseconds: 30),
                ),
              ),
              // Only display Chip if rating is not null
              if (movie.userRating != null)
                Positioned(
                  top: 4,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _fillColor(movie.userRating!),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                        width: 1.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      movie.userRating.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ]),
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center, // Center align the text
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Color _fillColor(int value) {
    if (value > 7) {
      return Colors.green.withOpacity(0.8);
    } else if (value >= 5) {
      return Colors.orange.withOpacity(0.8);
    } else {
      return Colors.red.withOpacity(0.8);
    }
  }
}
