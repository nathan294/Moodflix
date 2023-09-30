import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/movies/models/movie.dart';
import 'package:moodflix/features/movies/movie_details/bloc/bloc.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Détails du film"),
            ),
            body: _buildBody(movie, state));
      },
    );
  }
}

// Function to build the body, based on the state
Widget _buildBody(Movie movie, MovieDetailsState state) {
  if (state is DataLoadingState) {
    return const Center(child: CircularProgressIndicator());
  }
  if (state is DataLoadedState) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${movie.id}'),
          Text('Title: ${movie.title}'),
          Text("Genres: ${state.genreName.join(', ')}"),
          Text('Overview: ${movie.overview}'),
          Text('Release Year: ${movie.releaseYear}'),
          Text('Popularity: ${movie.popularity}'),
          Text('Vote Average: ${movie.voteAverage}'),
          Text('Vote Count: ${movie.voteCount}'),
        ],
      ),
    );
  } else {
    return const Center(child: Text("Une erreur est survenue"));
  }
}
