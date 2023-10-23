import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/movie_details/blocs/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/blocs/rating_cubit/rating_cubit.dart';
import 'package:moodflix/features/movie_details/widgets/movie_poster.dart';
import 'package:moodflix/features/movie_details/widgets/note.dart';
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

        // SizedBox between title and poster row
        const SizedBox(
          height: 10,
        ),

        // Rest of the content
        SizedBox(
          height: 230,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Average note
                  NoteWidget(value: movie.voteAverage, text: "Note moy."),

                  // User note
                  BlocBuilder<RatingCubit, RatingState>(
                    builder: (context, state) {
                      if (state is MovieNotRated) {
                        return const NoteWidget(
                            value: null, text: "Votre note");
                      } else if (state is MovieRated) {
                        return NoteWidget(
                            value: state.rating.toDouble(), text: "Votre note");
                      } else {
                        return const NoteWidget(
                            value: null, text: "Votre note");
                      }
                    },
                  ),
                  // PopularityScoreWidget(value: movie.popularity),
                ],
              ),
              MoviePosterWidget(
                imageUrl: movie.posterPath,
                height: 210.0, // Optionally specify a different height
              ),
            ],
          ),
        ),
      ],
    );
  }
}
