import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MoviesCarousel extends StatelessWidget {
  final List<Movie> movies;

  const MoviesCarousel({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    double carouselHeight = 225.0;
    double imageHeight = carouselHeight - 70;

    return CarouselSlider(
      options: CarouselOptions(
        height: carouselHeight,
        autoPlay: false,
        viewportFraction: 1 / 3, // Fraction of width each item takes up
        enlargeCenterPage: false, // Don't enlarge the center item
      ),
      items: movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                SizedBox(
                    height: imageHeight, // Height of the Image
                    child:
                        Image.network(movie.posterPath, fit: BoxFit.fitHeight)),
                const SizedBox(height: 5),
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis, // Add ellipsis for long text
                  maxLines: 1, // Limit to one line
                  style: const TextStyle(fontSize: 12),
                ),
                // Text('Average Note: ${movie.voteAverage}'),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
