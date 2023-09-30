import 'package:flutter/material.dart';
import 'package:moodflix/features/movie_details/bloc/bloc.dart';
import 'package:moodflix/features/movie_details/widgets/movie_poster.dart';
import 'package:moodflix/features/movie_details/widgets/avg_note.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MovieTitleRowWidget extends StatelessWidget {
  final Movie movie;
  final DataLoadedState state;
  const MovieTitleRowWidget({
    super.key,
    required this.movie,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Text(
              movie.title,
              style: const TextStyle(
                fontSize: 24, // Set the font size
                fontWeight: FontWeight.bold, // Set the font weight to bold
                height:
                    1, // Adjust this value to control the line spacing, 1.0 is the default value
              ),
              textAlign: TextAlign.left,
              maxLines: null, // Allows text to fall to the next lines
              //   overflow:
              //       TextOverflow.ellipsis, // Adds ellipsis when text overflows
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        // Rest of the content
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.genreName.join(', ')),
                  Text(movie.releaseYear.toString()),
                  AvgNoteWidget(value: movie.voteAverage),
                ],
              ),
            ),
            MoviePosterWidget(
              imageUrl: movie.posterPath ??
                  "https://e7.pngegg.com/pngimages/754/873/png-clipart-question-mark-question-mark.png",
              height: 200.0, // Optionally specify a different height
            ),
          ],
        ),
      ],
    );
  }
}
