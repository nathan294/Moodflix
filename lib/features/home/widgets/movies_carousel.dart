import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart'; // Import for context.push
import 'package:moodflix/features/movie_search/models/movie.dart';

class MoviesCarousel extends StatelessWidget {
  final List<Movie> movies;
  final String listTitle;

  const MoviesCarousel(
      {super.key, required this.movies, required this.listTitle});

  @override
  Widget build(BuildContext context) {
    double carouselHeight = 175.0;
    double imageHeight = carouselHeight - 25;

    return Column(
      children: [
        Text(
          listTitle,
          style: const TextStyle(
            fontSize: 20, // Set the font size
            fontWeight: FontWeight.bold, // Set the font weight to bold
            height:
                1, // Adjust this value to control the line spacing, 1.0 is the default value
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: carouselHeight,
            autoPlay: false,
            viewportFraction: 1 / 3, // Fraction of width each item takes up
            enlargeCenterPage: false, // Don't enlarge the center item
          ),
          items: movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  // Wrap with GestureDetector
                  onTap: () {
                    context.push('/movie/${movie.id}', extra: movie);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: imageHeight, // Height of the Image
                          child: Image.network(movie.posterPath,
                              fit: BoxFit.fitHeight)),
                      const SizedBox(height: 5),
                      Text(
                        movie.title,
                        overflow:
                            TextOverflow.ellipsis, // Add ellipsis for long text
                        maxLines: 1, // Limit to one line
                        style: const TextStyle(fontSize: 12),
                      ),
                      // Text('Average Note: ${movie.voteAverage}'),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
