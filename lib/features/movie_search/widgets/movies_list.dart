import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  const MoviesList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort the movies by popularity in descending order
    final sortedMovies = List.from(movies)
      ..sort((a, b) => b.popularity.compareTo(a.popularity));

    return ListView.builder(
      itemCount: sortedMovies.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = sortedMovies[index];
        String leadingImage = movie.posterPath != null
            ? movie.posterPath!
            : "https://e7.pngegg.com/pngimages/754/873/png-clipart-question-mark-question-mark.png"; // Replace with the URL of your image with an interrogation point

        return Card(
          child: Image.network(
            leadingImage,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                // The image has fully loaded, return the ListTile
                return ListTile(
                  leading: child,
                  title: Text(movie.title),
                  subtitle: Text("${movie.releaseYear}"),
                  trailing: movieAverageNote(movie),
                  onTap: () {
                    // Navigate to the movie details or do something else
                    context.push('/movie/${movie.id}', extra: movie);
                  },
                );
              }
              // The image is still loading, return an empty container
              return Container();
            },
            fit: BoxFit.fitHeight,
          ),
        );
      },
    );
  }
}

Widget movieAverageNote(Movie movie) {
  return Container(
    width: 25.0,
    height: 25.0,
    decoration: const BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        movie.voteAverage.toStringAsFixed(1),
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
