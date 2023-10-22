import 'package:flutter/material.dart';
import 'package:moodflix/features/movie_details/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/widgets/movie_title_row.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

List<Widget> buildBody(Movie movie, DataLoadedState state) {
  return [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieTitleRowWidget(movie: movie, state: state),
          Text(state.genreNames.join(', '),
              style: const TextStyle(fontStyle: FontStyle.italic)),
          Text(
            "Date de sortie : ${movie.releaseDate.toString()}\n",
          ),
          Text("Synopsis : ${movie.overview}"),
        ],
      ),
    ),
  ];
}
