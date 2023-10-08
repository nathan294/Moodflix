import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';
import 'package:moodflix/features/movie_details/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/ui/details_page.dart';

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
