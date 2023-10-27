import 'package:flutter/material.dart';
import 'package:moodflix/features/collection/widgets/wished_movies_list.dart';

class WishedMovies extends StatelessWidget {
  const WishedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Toutes vos envies")),
        body: const WishedMoviesList());
  }
}
