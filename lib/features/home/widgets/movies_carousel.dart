import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MoviesCarousel extends StatelessWidget {
  final List<Movie> movies;
  final String listTitle;

  const MoviesCarousel(
      {super.key, required this.movies, required this.listTitle});

  @override
  Widget build(BuildContext context) {
    double itemHeight = 230.0; // Global item height
    double padding = 8.0; // Padding around the image
    double titleHeight = 12.0; // Approximate Text height with fontSize 12
    double spacingTitleAndPoster =
        5; // Space between widget title and poster images
    double spacing = 3.0; // Space between image and title
    double posterHeight = itemHeight -
        (2 * padding) -
        titleHeight -
        spacing -
        spacingTitleAndPoster;
    double posterWidth = posterHeight * (2 / 3); // Calculate the poster width

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            listTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: spacingTitleAndPoster),
        SizedBox(
          height: itemHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              Movie movie = movies[index];
              return GestureDetector(
                onTap: () {
                  context.push('/movie/${movie.id}', extra: movie);
                },
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    children: [
                      // Movie poster
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          height: posterHeight,
                          width: posterWidth,
                          imageUrl: movie.posterPath,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.fitHeight,
                          fadeInDuration: const Duration(milliseconds: 100),
                          fadeOutDuration: const Duration(milliseconds: 30),
                        ),
                      ),
                      SizedBox(height: spacing),
                      // Movie title
                      SizedBox(
                        width: posterWidth,
                        child: Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
