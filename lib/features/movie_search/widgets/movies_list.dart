import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/core/functions/format_avg_note.dart';
import 'package:moodflix/core/functions/movie_rating_color.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  const MoviesList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort the movies by popularity in descending order
    final sortedMovies = List.from(movies);
    // ..sort((a, b) => b.popularity.compareTo(a.popularity));

    // Number of items
    final int itemCount = sortedMovies.length;
    // Height of an item
    const double itemHeight = 90.0;

    return ListView.separated(
      cacheExtent: itemCount * itemHeight,
      itemCount: itemCount,
      separatorBuilder: (context, index) => const Divider(
        height: 10, // Spacing between items
        thickness: 0.25, // Divider width
        endIndent: 20,
        indent: 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        final movie = sortedMovies[index];
        String leadingImage = movie.posterPath;
        return InkWell(
          onTap: () {
            // Navigate to the movie details or do something else
            context.push('/movie/${movie.id}', extra: movie);
          },
          child: SizedBox(
            height: itemHeight, // specify the height
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // stretch to full height
              children: [
                // Image with leading padding
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0), // Add leading padding
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                      width: 60, // adjust the width as needed
                      child: CachedNetworkImage(
                        imageUrl: leadingImage,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fitHeight,
                        fadeInDuration: const Duration(milliseconds: 90),
                        fadeOutDuration: const Duration(milliseconds: 30),
                      ),
                    ),
                  ),
                ),
                // Movie title and release year
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          overflow: TextOverflow
                              .ellipsis, // Add ellipsis for long text
                          maxLines: 2, // Limit to one line
                        ),
                        Text(
                          movie.releaseYear.toString(),
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                // Trailing Widget
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: movieAverageNote(movie),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget movieAverageNote(Movie movie) {
    return Container(
      width: 30.0,
      decoration: BoxDecoration(
        color: fillColor(movie.voteAverage, 1.0),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          fillAverageNoteValue(movie.voteAverage),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
