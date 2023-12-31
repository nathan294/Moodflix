import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart'; // Import for context.push
import 'package:moodflix/features/movie_search/models/movie.dart';

class PopularCarousel extends StatelessWidget {
  final List<Movie> movies;
  final String listTitle;

  const PopularCarousel(
      {super.key, required this.movies, required this.listTitle});

  @override
  Widget build(BuildContext context) {
    double carouselHeight = 250.0;
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
            autoPlay: true,
            viewportFraction: 1, // Fraction of width each item takes up
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
                          child: CachedNetworkImage(
                            imageUrl: movie.backdropPath,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 90),
                            fadeOutDuration: const Duration(milliseconds: 30),
                          )),
                      Text(movie.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
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
