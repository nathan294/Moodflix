import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/core/widgets/shimmer_image.dart';
import 'package:moodflix/features/movie_details/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/ui/details_body.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

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
                      fit: BoxFit.cover),
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
                  buildBody(movie, state),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
