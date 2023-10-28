import 'package:flutter/material.dart';
import 'package:moodflix/core/enum/movie_list_type.dart';
import 'package:moodflix/features/collection/widgets/movies_complete_list.dart';

class WishedMovies extends StatelessWidget {
  const WishedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Toutes vos envies")),
        body: const MoviesCompleteList(
            movieListType: MovieListType.wishedMovies));
  }
}
