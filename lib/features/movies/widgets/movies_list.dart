import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/features/movies/models/movie.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  const MoviesList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = movies[index];
        String leadingImage = movie.posterPath != null
            ? movie.posterPath!
            : "https://e7.pngegg.com/pngimages/754/873/png-clipart-question-mark-question-mark.png"; // Replace with the URL of your image with an interrogation point

        return Card(
          child: ListTile(
            leading: Image.network(
              leadingImage, // Make sure to have a posterPath in your Movie model

              fit: BoxFit.fitHeight,
            ),
            title: Text(movie.title),
            subtitle: Text("${movie.releaseYear}"),
            onTap: () {
              // Navigate to the movie details or do something else
              context.push('/movie/${movie.id}', extra: movie);
            },
          ),
        );
      },
    );
  }
}
