import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/core/enum/movie_list_type.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';
import 'package:moodflix/features/collection/widgets/rating_chip.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MoviesCompleteList extends StatelessWidget {
  final MovieListType movieListType;
  const MoviesCompleteList({super.key, required this.movieListType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
      // State will always be DataLoadedState
      if (state is DataLoadedState) {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            height: 15, // Spacing between items
            thickness: 0.5, // Divider width
            endIndent: 20,
            indent: 20,
          ),
          itemCount: state.ratedMovies.length,

          //
          // Individual ListTile (widget for each movie in the list)
          itemBuilder: (context, index) {
            Movie movie = state.ratedMovies[index];
            double leadingImageHeight = 130.0;

            // InkWell to handle click on the whole row to move to movie details
            return InkWell(
              onTap: () {
                context.push('/movie/${movie.id}', extra: movie);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                // For every movie, we create a Row widget
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Leading Image (movie poster)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        width: leadingImageHeight * 2 / 3,
                        height: leadingImageHeight,
                        imageUrl: movie.posterPath,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 90),
                        fadeOutDuration: const Duration(milliseconds: 30),
                      ),
                    ),

                    // Some spacing between the image and the text
                    const SizedBox(width: 16),

                    // Movie title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),

                    // Trailing Icon (or rating chip, depending of provided widget type)
                    if (movieListType == MovieListType.wishedMovies)
                      const Icon(
                        Icons.bookmark_added_rounded,
                        color: Colors.blueGrey,
                      ),
                    if (movieListType == MovieListType.ratedMovies)
                      RatingChip(movie: movie),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
