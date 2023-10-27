import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/features/collection/widgets/movie_card.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MovieListCard extends StatelessWidget {
  final List<Movie> movieList;
  final String cardTitle;
  final EdgeInsets padding;

  const MovieListCard({
    super.key,
    required this.movieList,
    required this.cardTitle,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double scaffoldBodyHeight = constraints.maxHeight;
        double calculatedHeight = (scaffoldBodyHeight / 2) - padding.vertical;

        // Update the moviePosterHeight based on the calculated height.
        int moviePosterHeight = (calculatedHeight * 1.3).toInt();
        return Padding(
          padding: padding,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: calculatedHeight,

              // Whole card
              child: Card(
                elevation: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Card title
                          Text(
                            cardTitle,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),

                          // Button to view all movies
                          TextButton(
                            onPressed: () {
                              // Handle "Voir tout" click
                            },
                            child: const Text('Voir tout'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Horizontal scrollable view to display movies
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: movieList
                              .take(10)
                              .map((movie) => Padding(
                                    padding: const EdgeInsets.only(right: 14),
                                    child: GestureDetector(
                                      onTap: () {
                                        context.push('/movie/${movie.id}',
                                            extra: movie);
                                      },
                                      child: MovieCard(
                                        movie: movie,
                                        moviePosterHeight:
                                            moviePosterHeight, // Pass the height
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
