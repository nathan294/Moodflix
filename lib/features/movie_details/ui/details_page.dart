import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/core/widgets/shimmer_image.dart';
import 'package:moodflix/features/movie_details/blocs/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/blocs/rating_cubit/rating_cubit.dart';
import 'package:moodflix/features/movie_details/blocs/wishlist_cubit/wishlist_cubit.dart';
import 'package:moodflix/features/movie_details/ui/details_body.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is DataLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DataLoadedState) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    RatingCubit(rating: state.rate, movie: movie),
              ),
              BlocProvider(
                create: (context) => WishlistCubit(
                    isAddedToWishlist: state.isWished, movieId: movie.id),
              ),
            ],
            child: Scaffold(
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
                          imageUrl: movie.backdropPath, fit: BoxFit.cover),
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
            ),
          );
        } else {
          return const Center(child: Text("Une erreur est survenue"));
        }
      },
    );
  }
}
