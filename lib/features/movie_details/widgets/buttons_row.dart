import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart'
    as collection_bloc;
import 'package:moodflix/features/collection/models/movie_list.dart';
import 'package:moodflix/features/movie_details/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/widgets/rate_button.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Get user's lists
    final collectionBloc = context.read<collection_bloc.CollectionBloc>();
    if (collectionBloc.state is collection_bloc.DataLoadedState) {
      MovieList? ratedMovies =
          (collectionBloc.state as collection_bloc.DataLoadedState)
              .moviesLists
              .firstWhere((movieList) => movieList.title == "Notes");

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RateButton(
              onRate: (note) => {
                    context
                        .read<MovieDetailsBloc>()
                        .add(RateMovieEvent(ratedMovies, note: note))
                  })
        ],
      );
    } else {
      return const Text("Erreur dans la récupération des notes et des listes");
    }
  }
}
