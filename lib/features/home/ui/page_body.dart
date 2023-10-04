import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/home/bloc/home_bloc.dart';
import 'package:moodflix/features/home/widgets/movies_carousel.dart';

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
                MoviesCarousel(
                    movies: state.popularMovies, listTitle: "Films populaires"),
                const SizedBox(
                  height: 30,
                ),
                MoviesCarousel(
                    movies: state.nowPlayingMovies, listTitle: "À l'affiche"),
                const SizedBox(
                  height: 30,
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
