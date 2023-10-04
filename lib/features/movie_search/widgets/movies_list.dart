import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/core/widgets/shimmer_image.dart';
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
        height: 5, // Adjust the height to control spacing
        color: Color.fromARGB(
            255, 205, 205, 205), // Optional: Set color for the divider
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
                  child: SizedBox(
                    width: 60, // adjust the width as needed
                    child: ShimmerImagePlaceholder(
                      imageUrl: leadingImage,
                      fit: BoxFit.fitHeight, // cover the entire space
                    ),
                  ),
                ),
                // Text and Other Info
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.title,
                          overflow: TextOverflow
                              .ellipsis, // Add ellipsis for long text
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 16), // Limit to one line
                        ),
                        Text(
                          "${movie.releaseYear}",
                          style: const TextStyle(fontSize: 11),
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
        color: _fillColor(movie.voteAverage),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _fillAverageNoteValue(movie.voteAverage),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Color _fillColor(double value) {
    if (value > 7) {
      return Colors.green;
    } else if (value > 5) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

String _fillAverageNoteValue(double voteAverage) {
  // Convert the number to a String with 1 digit
  String numberStr = voteAverage.toStringAsFixed(1);

  // Split the string at the decimal point
  List<String> parts = numberStr.split('.');
  // Get the first digit after the decimal point
  String decimalPart = parts[1];
  int firstDecimalDigit = int.parse(decimalPart[0]);
  if (firstDecimalDigit == 0) {
    return voteAverage.toStringAsFixed(0);
  } else {
    return voteAverage.toStringAsFixed(1);
  }
}
