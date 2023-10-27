import 'package:flutter/material.dart';
import 'package:moodflix/features/collection/widgets/rated_movies_list.dart';

class RatedMovies extends StatelessWidget {
  const RatedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Toutes vos notes")),
        body: const RatedMoviesList());
  }
}
