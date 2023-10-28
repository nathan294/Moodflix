import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/home/bloc/home_bloc.dart';
import 'package:moodflix/features/home/widgets/movies_carousel.dart';
import 'package:moodflix/features/home/widgets/popular_carousel.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is DataLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DataLoadedState) {
          return SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Column(
              children: [
                PopularCarousel(
                    movies: state.popularMovies, listTitle: "À la une"),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 1,
                  thickness: 0.5,
                  endIndent: 30,
                  indent: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                MoviesCarousel(
                    movies: state.nowPlayingMovies, listTitle: "À l'affiche"),
                const SizedBox(
                  height: 20,
                ),
                MoviesCarousel(
                    movies: state.upcomingMovies,
                    listTitle: "Prochaines sorties"),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
