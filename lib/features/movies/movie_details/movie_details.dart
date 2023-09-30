import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/movies/models/movie.dart';
import 'package:moodflix/features/movies/movie_details/bloc/bloc.dart';
import 'package:moodflix/features/movies/movie_details/ui/movie_details_page.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  const MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MovieDetailsBloc(context)
          ..add(LoadDataEvent(genreIds: movie.genreIds)),
        child: MovieDetailsPage(
          movie: movie,
        ));
  }
}
