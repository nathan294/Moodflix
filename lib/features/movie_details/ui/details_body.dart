import 'package:flutter/material.dart';
import 'package:moodflix/features/movie_details/bloc/bloc.dart';
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
            children: List<Widget>.generate(
              8, // Number of shimmer lines
              (index) => Container(
                width: double.infinity,
                height: 20.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.grey[300],
              ),
            ),
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
            const SizedBox(
              height: 30,
            ),
            Text(movie.overview),
            Text('Popularity: ${movie.popularity}'),
            Text('Vote Average: ${movie.voteAverage}'),
            Text('Vote Count: ${movie.voteCount}'),
          ],
        ),
      ),
    ];
  } else {
    return [const Center(child: Text("Une erreur est survenue"))];
  }
}
