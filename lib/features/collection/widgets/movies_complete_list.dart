import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/core/enum/movie_list_type.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';
import 'package:moodflix/features/collection/functions/map_list_type.dart';
import 'package:moodflix/features/collection/widgets/movie_row_widget.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MoviesCompleteList extends StatefulWidget {
  final MovieListType movieListType;
  const MoviesCompleteList({super.key, required this.movieListType});

  @override
  State<MoviesCompleteList> createState() => _MoviesCompleteListState();
}

class _MoviesCompleteListState extends State<MoviesCompleteList> {
  // Scroll controller will listen to scroll & will allow to fetch more data
  final ScrollController _scrollController = ScrollController();

  // ScrollController's listener in the initState
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  // ScrollController listener; when we arrive at the end of the list,
  // fetch data if we're not at the max
  void _onScroll() {
    final state = BlocProvider.of<CollectionBloc>(context).state;

    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !hasReachedMax(state, widget.movieListType)) {
      BlocProvider.of<CollectionBloc>(context)
          .add(fetchEvent(widget.movieListType));
    }
  }

  // Dispose the scroll controller to avoid memory leaks
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, CollectionState state) {
      if (state is DataLoadedState) {
        List<Movie> currentMovies = getMoviesList(state, widget.movieListType);

        // Determine the number of list items. Add one for the CircularProgressIndicator (when fetching data).
        int itemCount = hasReachedMax(state, widget.movieListType)
            ? currentMovies.length
            : currentMovies.length + 1;

        if (currentMovies.isNotEmpty) {
          return ListView.separated(
            controller: _scrollController,
            separatorBuilder: (context, index) => const Divider(
              height: 15, // Spacing between items
              thickness: 0.35, // Divider width
              endIndent: 20,
              indent: 20,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              // If it's the extra item, return a CircularProgressIndicator (or a Containerif we have reached the max)
              if (index >= currentMovies.length) {
                return hasReachedMax(state, widget.movieListType)
                    ? Container()
                    : const Center(child: CircularProgressIndicator());
              }

              // Individual ListTile (widget for each movie in the list)
              Movie movie = currentMovies[index];
              return InkWell(
                // InkWell to handle click on the whole row to move to movie details
                onTap: () {
                  context.push('/movie/${movie.id}', extra: movie);
                },
                // MovieRowWidget contains the display of every movie
                child: MovieRowWidget(
                    movie: movie, movieListType: widget.movieListType),
              );
            },
          );
        } else {
          return const Center(
            child: Text("Vous n'avez aucun film dans votre liste de souhait."),
          );
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
