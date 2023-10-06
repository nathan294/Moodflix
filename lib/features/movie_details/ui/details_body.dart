import 'package:flutter/material.dart';
import 'package:moodflix/features/movie_details/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/widgets/movie_title_row.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';
import 'package:shimmer/shimmer.dart';

List<Widget> buildBody(Movie movie, MovieDetailsState state) {
  if (state is DataLoadingState) {
    return [
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mimic the title
              Container(
                width: double.infinity,
                height: 30.0,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 8),
              // Mimic the genre and year
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 20.0,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 40,
                    height: 20.0,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Mimic the AvgNoteWidget
              Container(
                width: 50,
                height: 50.0,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 30),
              // Mimic the overview
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List<Widget>.generate(
                  8, // Number of shimmer lines for overview
                  (index) => Container(
                    width: double.infinity,
                    height: 20.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }
  if (state is DataLoadedState) {
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieTitleRowWidget(movie: movie, state: state),
            Text(state.genreName.join(', '),
                style: const TextStyle(fontStyle: FontStyle.italic)),
            Text(
              "Date de sortie : ${movie.releaseDate.toString()}\n",
            ),
            Text("Synopsis : ${movie.overview}"),
          ],
        ),
      ),
    ];
  } else {
    return [const Center(child: Text("Une erreur est survenue"))];
  }
}
