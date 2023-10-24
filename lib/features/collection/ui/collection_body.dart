import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';
import 'package:moodflix/features/collection/widgets/movie_list_temp.dart';

class CollectionBody extends StatefulWidget {
  const CollectionBody({super.key});

  @override
  State<CollectionBody> createState() => _CollectionBodyState();
}

class _CollectionBodyState extends State<CollectionBody> {
  // final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        if (state is DataLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is DataErrorState) {
          return const Text('Erreur dans le chargement des données');
        } else if (state is DataLoadedState) {
          return MovieListWidget(movieList: state.wishedMovies);
        } else {
          return const Text('Une erreur inconnue est surveneue');
        }
      },
    );
  }
}
