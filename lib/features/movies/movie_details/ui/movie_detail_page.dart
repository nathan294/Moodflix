import 'package:flutter/material.dart';
import 'package:moodflix/features/movies/models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${movie.id}'),
            Text('Title: ${movie.title}'),
            Text('Genres: ${movie.genreIds.join(", ")}'),
            Text('Original Language: ${movie.originalLanguage}'),
            Text('Original Title: ${movie.originalTitle}'),
            Text('Overview: ${movie.overview}'),
            Text('Poster Path: ${movie.posterPath ?? "N/A"}'),
            Text('Backdrop Path: ${movie.backdropPath ?? "N/A"}'),
            Text('Release Date: ${movie.releaseDate}'),
            Text('Release Year: ${movie.releaseYear}'),
            Text('Popularity: ${movie.popularity}'),
            Text('Vote Average: ${movie.voteAverage}'),
            Text('Vote Count: ${movie.voteCount}'),
          ],
        ),
      ),
    );
  }
}
