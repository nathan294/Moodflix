import 'package:flutter/material.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MovieListWidget extends StatelessWidget {
  final List<Movie> movieList;
  const MovieListWidget({super.key, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movieList.length, // 0 to 10
        itemBuilder: (BuildContext context, int index) {
          Movie currentMovie = movieList[index];
          return ListTile(
            title: Text(currentMovie.title),
            onTap: () {
              // Navigator.of(context).pop(index);
            },
          );
        });
  }
}
