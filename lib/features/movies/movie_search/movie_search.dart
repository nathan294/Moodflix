import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/movies/movie_search/bloc/bloc.dart';
import 'package:moodflix/features/movies/movie_search/ui/search_page.dart';

class MovieSearch extends StatelessWidget {
  const MovieSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MovieSearchBloc(context), child: SearchPage());
  }
}
