import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/core/widgets/shimmer_image.dart';
import 'package:moodflix/features/movies/models/movie.dart';
import 'package:moodflix/features/movies/movie_details/bloc/bloc.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          extendBodyBehindAppBar: true,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: ShimmerImagePlaceholder(
                    imageUrl: movie.backdropPath ??
                        'https://e7.pngegg.com/pngimages/754/873/png-clipart-question-mark-question-mark.png',
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  _buildBody(movie, state),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

List<Widget> _buildBody(Movie movie, MovieDetailsState state) {
  if (state is DataLoadingState) {
    return [
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(
              8, // Number of shimmer lines
              (index) => Container(
                width: double.infinity,
                height: 20.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
      ),
    ];
  }
  if (state is DataLoadedState) {
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${movie.id}'),
            Text('Title: ${movie.title}'),
            Text("Genres: ${state.genreName.join(', ')}"),
            Text('Overview: ${movie.overview}'),
            Text('Release Year: ${movie.releaseYear}'),
            Text('Popularity: ${movie.popularity}'),
            Text('Vote Average: ${movie.voteAverage}'),
            Text('Vote Count: ${movie.voteCount}'),
          ],
        ),
      ),
    ];
  } else {
    return [const Center(child: Text("Une erreur est survenue"))];
  }
}
