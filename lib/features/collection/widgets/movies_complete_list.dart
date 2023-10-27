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

  @override
  void initState() {
    super.initState();
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
      // Store the current state in a variable for use in the ScrollController
      final currentState = state;

      // ScrollController listener; when we arrive at the end of the list,
      // fetch data if we're not at the max
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!hasReachedMax(currentState, widget.movieListType)) {
            BlocProvider.of<CollectionBloc>(context)
                .add(fetchEvent(widget.movieListType));
          }
        }
      });

      // State will always be DataLoadedState
      if (state is DataLoadedState) {
        List<Movie> currentMovies = getMoviesList(state, widget.movieListType);
        // Determine the number of list items. Add one for the CircularProgressIndicator (when fetching data).
        int itemCount = hasReachedMax(state, widget.movieListType)
            ? currentMovies.length
            : currentMovies.length + 1;

        return ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) => const Divider(
            height: 15, // Spacing between items
            thickness: 0.5, // Divider width
            endIndent: 20,
            indent: 20,
          ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            // If it's the extra item, return a CircularProgressIndicator
            if (index >= currentMovies.length) {
              return const Center(child: CircularProgressIndicator());
            }

            // Individual ListTile (widget for each movie in the list)
            Movie movie = currentMovies[index];

            // InkWell to handle click on the whole row to move to movie details
            return InkWell(
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
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
