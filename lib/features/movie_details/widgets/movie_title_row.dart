import 'package:flutter/material.dart';
import 'package:moodflix/features/movie_details/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/widgets/movie_poster.dart';
import 'package:moodflix/features/movie_details/widgets/avg_note.dart';
import 'package:moodflix/features/movie_details/widgets/popularity_score.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Center(
            child: Text(
              movie.title,
              style: const TextStyle(
                fontSize: 25, // Set the font size
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

        // Rest of the content
        SizedBox(
          height: 230,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AvgNoteWidget(value: movie.voteAverage),
                  PopularityScoreWidget(value: movie.popularity),
                ],
              ),
              MoviePosterWidget(
                imageUrl: movie.posterPath ??
                    "https://e7.pngegg.com/pngimages/754/873/png-clipart-question-mark-question-mark.png",
                height: 200.0, // Optionally specify a different height
              ),
            ],
          ),
        ),
      ],
    );
  }
}
