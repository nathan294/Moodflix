import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodflix/features/movie_details/blocs/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/ui/buttons_row.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ButtonsRow(movie: movie, state: state),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(state.genreNames.join(', '),
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w600)),
          Text(
            DateFormat('d MMMM y', 'fr_FR')
                .format(DateTime.parse(movie.releaseDate)),
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            movie.overview,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
  ];
}
