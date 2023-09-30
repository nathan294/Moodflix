import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/features/movies/models/movie.dart';

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
