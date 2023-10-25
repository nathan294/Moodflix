import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';
import 'package:moodflix/features/collection/widgets/movie_list_card.dart';

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
          return const Center(child: CircularProgressIndicator());
        } else if (state is DataErrorState) {
          return const Text('Erreur dans le chargement des données');
        } else if (state is DataLoadedState) {
          return Column(
            children: [
              MovieListCard(
                cardTitle: "Vos dernières notes",
                movieList: state.ratedMovies,
                padding: const EdgeInsets.only(bottom: 8, top: 3),
              ),
              MovieListCard(
                cardTitle: "Vos envies récentes",
                movieList: state.wishedMovies,
                padding: const EdgeInsets.only(top: 8, bottom: 3),
              ),
            ],
          );
        } else {
          return const Text('Une erreur inconnue est surveneue');
        }
      },
    );
  }
}
